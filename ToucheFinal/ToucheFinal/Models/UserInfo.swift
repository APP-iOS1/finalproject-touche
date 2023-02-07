//
//  User.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/17.
//

import Foundation


// <<<<<<< 0206/EditMyProfileStorage/SKH
//enum Nation: String, Codable {
//    case None
//    case RepublicOfKorea
//    case France
//    case UnitedStates
//    case Japan
    
//    var name: String {
//        switch self {
//        case .None: return "Select your nation."
//        case .RepublicOfKorea: return "Republic of Korea"
//       case .France: return "France"
//       case .UnitedStates: return "USA"
//        case .Japan: return "Japan"
//        }
//    }
    
//    var flag: String {
//        switch self {
//        case .None: return "🌎"
//        case .RepublicOfKorea: return "🇰🇷"
//        case .France: return "🇫🇷"
//        case .UnitedStates: return "🇺🇸"
//        case .Japan: return "🇯🇵"
//       }
//    }
//}

//enum Nation: Codable {
//    case None
//    case RepublicOfKorea
//    case France
//    case UnitedStates
//    case Japan
//}


struct UserInfo: Codable {
    var userId: String
    var userNation: String
    var userNickName: String
    var userProfileImage: String
    var userEmail: String
    var writtenComments: [String]
    var recentlyPerfumesId: [String]
}
