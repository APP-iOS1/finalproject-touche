//
//  User.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/17.
//

import Foundation


enum Nation {
    case RepublicOfKorea
    case France
    case UnitedStates
    case Japan
}

struct UserInfo {
    var userId: String
    var userNation: Nation
    var userNickName: String
    var userProfileImage: String
    var userEmail: String
    var likedComment: String
}
