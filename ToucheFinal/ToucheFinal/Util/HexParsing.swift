//
//  HexParsing.swift
//  ToucheFinal
//
//  Created by james seo on 2023/02/03.
//

import Foundation
/// 향수의 scentType으로 부터 hex 값을 parsing하는 함수
/// - Parameter scentType: perfume의 scentType 프로퍼티
/// - Returns: hex 값
func setHexValue(scentType: String) -> String {
    var hexValue: String = ""
    
    for type in PerfumeColor.types {
        if scentType == type.name {
            hexValue = type.hexValue
        }
    }
    
    return hexValue
}