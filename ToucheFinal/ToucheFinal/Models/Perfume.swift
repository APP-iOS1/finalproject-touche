//
//  Perfume.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/17.
//

import Foundation

struct Perfume: Codable {
    var perfumeId: String
    var brandName: String
    var displayName: String
    var heroImage: String
    var image450: String
    var fragranceFamily : String
    var scentType : String
    var keyNotes : [String]
    var fragranceDescription : String
    var likedPeople: [String]   //  좋아요 누른 사람의 id가 들어가도록
    var commentCount: Int
    var totalPerfumeScore: Int
}
