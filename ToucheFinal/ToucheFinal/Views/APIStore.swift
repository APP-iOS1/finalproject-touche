//
//  APIStore.swift
//  test
//
//  Created by TAEHYOUNG KIM on 2023/01/17.
//

import Foundation

class APIStore: ObservableObject {
    @Published var products: [Product] = []
    @Published var longDescriptions: [String] = []
    func fetchlistData(page: Int = 1) {
        let headers = [
            "X-RapidAPI-Key": "07ba238682msh382f2ec67220ceep18ca83jsn5ac3d937c097",
            "X-RapidAPI-Host": "sephora.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://sephora.p.rapidapi.com/products/list?categoryId=cat60148&pageSize=60&currentPage=\(page)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
//        do {
//            let (data, response) = try await URLSession.shared.data(for: request as URLRequest)
//        } catch {
//            print(error)
//        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
//                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                //                print(httpResponse)
                guard let jsonData = try? JSONDecoder().decode(Result.self, from: data ?? Data()) else {
                    print("jsonError")
                    return
                }

                /// [Product]
//                self.products = jsonData.products
                for product in jsonData.products {
//                    print("productId: \(product.productId), brand: \(product.brandName), displayName: \(product.displayName)")
                    self.fetchDetailData(productId: product.productId)
                    
                    
//                                        print(product.image450)
                }
                
                /// [Detail]
//                for product in jsonData.products {
//                    self.fetchDetailData(productId: "P501018")
//                }
//                self.fetchDetailData(productId: "P501018")
            }
        })

        dataTask.resume()
    }
    
//    func fetchAllDetail() {
//        guard !products.isEmpty else { return }
//        products.forEach { product in
//            fetchDetailData(productId: product.productId)
//        }
//    }
    
    func fetchDetailData(productId: String) {
//        var longDescription: String = ""
        let headers = [
            "X-RapidAPI-Key": "07ba238682msh382f2ec67220ceep18ca83jsn5ac3d937c097",
            "X-RapidAPI-Host": "sephora.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://sephora.p.rapidapi.com/products/detail?productId=\(productId)&preferedSku=2210607")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 60.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                if let jsonData = try? JSONDecoder().decode(Detail.self, from: data ?? Data()) {
                    print("longDescription: ",jsonData.longDescription)
//                    self.longDescriptions.append(jsonData.longDescription)
                } else {
                    print("json decoding fail: ",error)
                }
                
//                print(jsonData.longDescription)

            }
        })

        dataTask.resume()
//        return longDescription
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
}

struct Detail: Codable {
    var longDescription: String

}
