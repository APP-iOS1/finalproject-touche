//
//  Perfume.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/17.
//

import Foundation

/// firestore 용 데이터 모델
struct Perfume: Codable {
    var perfumeId: String
    var brandName: String
    var displayName: String
    var heroImage: String
    // sephora API: products/detail -> longDescription
    var fragranceFamily : String // Fragrance Family : Fresh
    var scentType: String // Scent Type : Fresh Fruity Florals
    var keyNotes: [String] // Key Notes :  Citron, Jasmine, Teakwood => [ Citron, Jasmine, Teakwood ]
    // quickLookDescription
    var fragranceDescription: String
}
