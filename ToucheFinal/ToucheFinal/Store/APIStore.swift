//
//  APIStore.swift
//  test
//
//  Created by TAEHYOUNG KIM on 2023/01/17.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftSoup

class APIStore: ObservableObject {
    @Published var notice: String = ""
    @Published var products: [Product] = []
    @Published var perfumes: [Perfume] = []
    
    // ==========================================
    private var cursor: QueryDocumentSnapshot?
    private let pageSize = 3
    // ==========================================
    
    var cancellables = Set<AnyCancellable>()
    let path = Firestore.firestore()
    
    func reset() {
        notice = ""
    }
    
    func fetch() {
        switch cursor {
        case nil:
            path.collection("Perfume")
                .limit(to: pageSize)
                .getDocuments { [weak self] (snapshot: QuerySnapshot?, _ :Error?) in
                    guard let snapshot = snapshot else { return }
                    
                    guard let lastSnapshot = snapshot.documents.last else {
                        // The collection is empty.
                        self?.cursor = nil
                        return
                    }
                    
                    self?.cursor = lastSnapshot
                    
                    self?.perfumes = snapshot.documents.compactMap { query -> Perfume? in
                        do {
                            return try query.data(as: Perfume.self)
                        } catch {
                            return nil
                        }
                    }
                }
        default:
            path.collection("Perfume")
                .limit(to: pageSize)
                .start(afterDocument: cursor!)
                .getDocuments { [weak self] (snapshot: QuerySnapshot?, _ :Error?) in
                    guard let snapshot = snapshot else { return }
                    
                    guard let lastSnapshot = snapshot.documents.last else {
                        // The collection is empty.
                        self?.cursor = nil
                        return
                    }
                    
                    self?.cursor = lastSnapshot
                    
                    self?.perfumes = snapshot.documents.compactMap { query -> Perfume? in
                        do {
                            return try query.data(as: Perfume.self)
                        } catch {
                            return nil
                        }
                    }
                }

        }
    }
    
    func fetchlistDataAndPostToFirestore(page: Int = 1) {
        notice = "대기"
        let headers = [
            "X-RapidAPI-Key": "bd60134ebbmsh47ad7cc85cd24d7p1cbc4ejsn3ed23622063e",
            "X-RapidAPI-Host": "sephora.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://sephora.p.rapidapi.com/products/list?categoryId=cat60148&pageSize=60&currentPage=\(page)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTaskPublisher(for: request as URLRequest)
            .receive(on: DispatchQueue.main)
            .tryCompactMap { task -> Data? in
                if let response = task.response as? HTTPURLResponse {
                    switch response.statusCode {
                    case 200..<300:
                        return task.data
                    default:
                        self.notice = "\(response.statusCode) error"
                        print(response.description)
                        throw URLError(.badURL)
                    }
                }
                return nil
            }
            .decode(type: Result.self, decoder: JSONDecoder())
            .map { $0.products }
            .retry(3)
            .sink { [weak self] in
                switch $0 {
                case .finished:
                    self?.notice = "성공"
                case .failure(let error):
                    self?.notice =  "fail: \(error)"
                }
            } receiveValue: { [weak self] products in
                products.forEach { product in
                    do {
                        try self?.path.collection("temps").document(product.productId).setData(from: product)
                    } catch {
                        self?.notice = "error: \(error)"
                    }
                }
                
            }
            .store(in: &cancellables)
    }
    
    @Sendable @MainActor
    func refreshProductData() async -> Void {
        self.products = await withCheckedContinuation { (continuation: CheckedContinuation<[Product], Never>) in
            path.collection("Temp")
                .limit(to: pageSize)
                .getDocuments { (snapshot: QuerySnapshot?, _ :Error?) in
                    guard let snapshot = snapshot else { return }
                    let products = snapshot.documents.compactMap { query -> Product? in
                        do {
                            return try query.data(as: Product.self)
                        } catch {
                            return nil
                        }
                    }
                    continuation.resume(returning: products)
                }
        }
    }
    
    func fetchDetailData(product: Product) {
        
        // ------------------- products/detail fetching ------------------------------
        
        let headers = [
            "X-RapidAPI-Key": "bd60134ebbmsh47ad7cc85cd24d7p1cbc4ejsn3ed23622063e",
            "X-RapidAPI-Host": "sephora.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://sephora.p.rapidapi.com/products/detail?productId=\(product.productId)&preferedSku=2210607")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        var longDescription: String = ""
        var quickDescription: String = ""
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print("datatask error : ", error?.localizedDescription)
            } else {
                if let jsonData = try? JSONDecoder().decode(Detail.self, from: data ?? Data()),
                   let response = response as? HTTPURLResponse {
                    print("longDescription: ",jsonData.longDescription)
                    print(response.statusCode)
                    longDescription = jsonData.longDescription
//                    quickDescription = jsonData.quickLookDescription
                    do {
                        quickDescription = try SwiftSoup.parse(jsonData.quickLookDescription).text()
                    } catch {}
                    
                    // --------------------- (family, finalType, finalKeyNotes) ------------------
                    
                    let (family, finalType, finalKeyNotes) = makeDescription(longDesc: longDescription)
                    
                    // ------------------ firestore ------------------------------
                    let perfume: [String: Any] = [
                        "perfumeId": product.productId,
                        "brandName": product.brandName,
                        "displayName": product.displayName,
                        "heroImage": product.heroImage,
                        "image450": product.image450,
                        "fragranceFamily": family,
                        "scentType": finalType,
                        "keyNotes": finalKeyNotes,
                        "fragranceDescription": quickDescription,
                        "likedPeople": [],
                        "commentCount": 0,
                        "totalPerfumeScore": 0
                        
                    ]
                    print("perfume", perfume)
                    self.path.collection("Perfume").document(product.productId)
                        .setData(perfume)
                } else {
                    print("json decoding fail: ",error?.localizedDescription)
                }
            }
        })
        
        dataTask.resume()
        
        //        guard !(longDescription.isEmpty && quickDescription.isEmpty) else {
        //            return }
        
    }
}

var productId = "P257900"

struct Result: Codable{
    var products: [Product]
}

/// 1. [Product] -> [Products.productId] -> [Detail.longDescription]

struct Product: Codable {
    var brandName: String
    var displayName: String
    var heroImage: String
    var productId: String
    var image450: String
}

struct Detail: Codable {
    var longDescription: String
    var quickLookDescription: String
    
}
