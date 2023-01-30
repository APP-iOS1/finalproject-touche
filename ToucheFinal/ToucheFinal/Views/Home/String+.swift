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
}
