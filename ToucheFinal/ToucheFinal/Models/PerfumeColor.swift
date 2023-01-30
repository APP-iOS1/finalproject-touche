//
//  PerfumeColor.swift
//  ToucheFinal
//
//  Created by james seo on 2023/01/30.
//

import SwiftUI

struct PerfumeColor: Identifiable {
    var id = UUID().uuidString
    var name: String
    var hexValue: String
    var color: Color {
        Color(hex: hexValue) ?? Color.clear
    }
    
    static var types: [PerfumeColor] = [
        PerfumeColor(name: "Warm & Sweet Gourmands", hexValue: "A11818"),
        PerfumeColor(name: "Fruity Florals", hexValue: "EC3C3C"),
        PerfumeColor(name: "Powdery Florals", hexValue: "D933C7"),
        PerfumeColor(name: "Classic Florals", hexValue: "EC96E3"),
        PerfumeColor(name: "Warm Florals", hexValue: "E26262"),
        PerfumeColor(name: "Fresh Florals", hexValue: "FF9680"),
        PerfumeColor(name: "Fresh Citrus & Fruits", hexValue: "FCE182"),
        PerfumeColor(name: "Fresh Solar", hexValue: "F0BC00"),
        PerfumeColor(name: "Earthy Greens & Herbs", hexValue: "4B9A4E"),
        PerfumeColor(name: "Cool Spices", hexValue: "326D98"),
        PerfumeColor(name: "Fresh Aquatics", hexValue: "2C5DDA"),
        PerfumeColor(name: "Warm Woods", hexValue: "895151"),
        PerfumeColor(name: "Classic Woods", hexValue: "595252"),
        PerfumeColor(name: "Woody Spices", hexValue: "513737"),
        PerfumeColor(name: "Citrus & Woods", hexValue: "B2A795"),
        PerfumeColor(name: "Warm & Sheer", hexValue: "B8B0B0"),
    ]
}

