//
//  Comment.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/17.
//

import Foundation

struct Comment: Codable, Hashable {
    var commentId: String
    var commentTime: Double
    var contents: String
    var perfumeScore: Int
    var writerId: String
    var writerNickName: String
    var writerImage: String
    var likedPeople: [String]
}
