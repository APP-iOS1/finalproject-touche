//
//  Color+.swift
//  ToucheFinal
//
//  Created by james seo on 2023/01/30.
//

import SwiftUI

extension Color {
    /// hex값을 Color값으로 converting
    ///
    /// link: [https://blog.eidinger.info/from-hex-to-color-and-back-in-swiftui](https://blog.eidinger.info/from-hex-to-color-and-back-in-swiftui)
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0

        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0

        } else {
            return nil
        }

        self.init(red: r, green: g, blue: b, opacity: a)
    }
    
    init(scentType: String) {
        var color = Color(.white)
        switch scentType {
        case "Warm & Sweet Gourmands":
            color = Color(hex: "A11818") ?? Color(.white)
        case "Fruity Florals":
            color = Color(hex: "EC3C3C") ?? Color(.white)
        case "Powdery Florals":
            color = Color(hex: "D933C7") ?? Color(.white)
        case "Classic Florals":
            color = Color(hex: "EC96E3") ?? Color(.white)
        case "Warm Florals":
            color = Color(hex: "E26262") ?? Color(.white)
        case "Fresh Florals":
            color = Color(hex: "FF9680") ?? Color(.white)
        case "Fresh Citrus & Fruits":
            color = Color(hex: "FCE182") ?? Color(.white)
        case "Fresh Solar":
            color = Color(hex: "F0BC00") ?? Color(.white)
        case "Earthy Greens & Herbs":
            color = Color(hex: "4B9A4E") ?? Color(.white)
        case "Cool Spices":
            color = Color(hex: "326D98") ?? Color(.white)
        case "Fresh Aquatics":
            color = Color(hex: "2C5DDA") ?? Color(.white)
        case "Warm Woods":
            color = Color(hex: "895151") ?? Color(.white)
        case "Classic Woods":
            color = Color(hex: "595252") ?? Color(.white)
        case "Woody Spices":
            color = Color(hex: "513737") ?? Color(.white)
        case "Citrus & Woods":
            color = Color(hex: "B2A795") ?? Color(.white)
        case "Warm & Sheer":
            color = Color(hex: "B8B0B0") ?? Color(.white)
        default:
            color = Color(.white)
        }
        self = color
    }
}

