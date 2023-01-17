//
//  SephoraFirebaseView.swift
//  ToucheFinal
//
//  Created by 서광현 on 2023/01/17.
//

import SwiftUI

//TODO: Sephora Data -> Firebase/Firestore 옮기기
/// 1. Sephora Data Fetching 되는가? **[OK!]**
/// 2. 원하는 데이터만 선택해서 Firestore에 저장되는가?
struct SephoraFirebaseView: View {
    
//    let headers = [
//        "X-RapidAPI-Key": "bd60134ebbmsh47ad7cc85cd24d7p1cbc4ejsn3ed23622063e",
//        "X-RapidAPI-Host": "sephora.p.rapidapi.com"
//    ]
//
//    func fetchSephoraData(productId: String) {
//        let request = NSMutableURLRequest(
//            url: NSURL(string: "https://sephora.p.rapidapi.com/products/detail?productId=\(productId)&preferedSku=2210607")! as URL,
//            cachePolicy: .useProtocolCachePolicy,
//            timeoutInterval: 10.0
//        )
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = headers
//
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            if let error = error {
//                print(error)
//            }
//            let httpResponse = response as? HTTPURLResponse
            
//            guard let jsonData = try? JSONDecoder().decode(Result.self, from: data ?? Data()) else {
//                print("jsonError")
//                return
//            }
//            print(jsonData)
//        })
//        dataTask.resume()
//    }
//
//    let productIds = [ "P449116",
//                       "P501018",
//                       "P417179",
//    ]
    
    @State private var productId: String = ""
    @StateObject var store: APIStore = APIStore()
    
    var body: some View {
        VStack {
            TextField("productId", text: $productId)
            
            Button("데이터 받기") {
                store.fetchlistData(page: 1)
//                    store.fetchAllDetail()
//                    print(store.products)
//                    print(store.longDescriptions)
//                print(
//                    store.fetchDetailData(productId: "P385358")
//                )
            }
        }
    }
}

struct SephoraFirebaseView_Previews: PreviewProvider {
    static var previews: some View {
        SephoraFirebaseView()
    }
}

// sephora api fetch 용 데이터 모델
//struct Result: Codable{
//    var longDescription: String
//    var displayName: String
//
//}

//var perfumeId: String
//var brandName: String
//var displayName: String
//var heroImage: String
//var fragranceFamily : String
//var scentType : String
//var keyNotes : [String]
//var fragranceDescription : String

//struct Product: Codable {
//    var brandName: String
//    var displayName: String
//    var image450: String
//}
