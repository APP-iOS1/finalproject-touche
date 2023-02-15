//
//  String+.swift
//  ToucheFinal
//
//  Created by 조석진 on 2023/01/20.
//

import Foundation

extension String{
    func tenString() -> String {
        let endIndex = self.index(self.startIndex, offsetBy: 14)
        return String(self[...endIndex])
    }
    
    func stringss(num: Int) -> String {
        return String(self.prefix(num))
    }
    
    func flag() -> String {
        switch self {
        case "United States of America":
            return "🇺🇸"
        case "Republic of Korea":
            return "🇰🇷"
        case "France":
            return "🇫🇷"
        case "España":
            return "🇪🇸"
        case "Canada":
            return "🇨🇦"
        default:
            return ""
        }
    }
    
    func isValidNickname() -> Bool {
        let regex = "^.*([a-zA-Z0-9])+.*$"
        let nickNameTest = NSPredicate(format:"SELF MATCHES %@", regex)
        return nickNameTest.evaluate(with: self)
    }
}
