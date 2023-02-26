//
//  User.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/17.
//

import Foundation


// <<<<<<< 0206/EditMyProfileStorage/SKH
enum Nation: String, Codable {
    case None = "🌎"
    case UnitedStates = "🇺🇸"
    case RepublicOfKorea = "🇰🇷"
    case France = "🇫🇷"
    case Espana = "🇪🇸"
    case Canada = "🇨🇦"
    
    /*
    var nationality: String {
        switch self {
        case .None: return "Select your nation."
        case .UnitedStates: return "USA"
        case .RepublicOfKorea: return "Republic of Korea"
        case .France: return "France"
        case .Espana: return "España"
        case .Canada: return "Canada"
        }
    }
    
    var flag: String {
        switch self {
        case .None: return "🌎"
        case .UnitedStates: return "🇺🇸"
        case .RepublicOfKorea: return "🇰🇷"
        case .France: return "🇫🇷"
        case .Espana: return "🇪🇸"
        case .Canada: return "🇨🇦"
        }
    }
     */
    
    var flag: String {
        switch self {
        case .None: return "Select Your Region"
        case .UnitedStates: return "United States"
        case .RepublicOfKorea: return "Republic of Korea"
        case .France: return "France"
        case .Espana: return "España"
        case .Canada: return "Canada"
        }
    }
    
    /*
    var nationality: String {
        switch self {
        case .None: String = "🌎"
        case .UnitedStates: return "🇺🇸"
        case .RepublicOfKorea: return "🇰🇷"
        case .France: return "🇫🇷"
        case .Espana: return "🇪🇸"
        case .Canada: return "🇨🇦"
        }
    }
     */
}


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
    //var userNation: Nation
    var userNickName: String
    var userProfileImage: String
    var userEmail: String
    var writtenComments: [String]
    var recentlyPerfumesId: [String]
}
