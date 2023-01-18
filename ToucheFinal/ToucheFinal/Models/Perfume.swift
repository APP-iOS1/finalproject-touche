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
    var image450: String
    // sephora API: products/detail -> longDescription
    var fragranceFamily : String // Fragrance Family : Fresh
    var scentType: String // Scent Type : Fresh Fruity Florals
    var keyNotes: [String] // Key Notes :  Citron, Jasmine, Teakwood => [ Citron, Jasmine, Teakwood ]
    // quickLookDescription
    var fragranceDescription: String
    /// - userId를 배열에 담아서 좋아요를 여부를 판단하려고 합니다.
    /// - 배열의 숫자로 좋아요 숫자를 확인하려고 합니다.
    var likedPeople: [String]
    /// - 댓글 숫자를 파악하기 위해서 추가하려고 합니다.
    var commentCount: Int
    /// - 댓글 입력시 정하는 별점으로 totalPerfumeScore / commentCount로 평점을 구하려고 합니다.
    /// - commentCount와 totalPerfumeScore는 댓글이 입력될때마다 업데이트 해줘야 합니다.
    var totalPerfumeScore: Int
}
