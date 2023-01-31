//
//  PerfumeColor.swift
//  ToucheFinal
//
//  Created by james seo on 2023/01/30.
//
import Foundation
import SwiftUI


struct Bookmark: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    var items: [Bookmark]?
    
    // some example websites
    static let apple = Bookmark(name: "Apple", icon: "1.circle")
    static let bbc = Bookmark(name: "BBC", icon: "square.and.pencil")
    static let swift = Bookmark(name: "Swift", icon: "bolt.fill")
    static let twitter = Bookmark(name: "Twitter", icon: "mic")
    
    // some example groups
    static let example1 = Bookmark(name: "Favorites", icon: "star", items: [Bookmark.apple, Bookmark.bbc, Bookmark.swift, Bookmark.twitter])
    
    static let example2 = Bookmark(name: "Recent", icon: "timer", items: [Bookmark.apple, Bookmark.bbc, Bookmark.swift, Bookmark.twitter])
    
    static let example3 = Bookmark(name: "Recommended", icon: "hand.thumbsup", items: [Bookmark.apple, Bookmark.bbc, Bookmark.swift, Bookmark.twitter])
}

struct PerfumeColor: Identifiable, Hashable {
    var id = UUID().uuidString

    var name: String
    var hexValue: String
    var color: Color {
        Color(hex: hexValue) ?? Color.clear
    }
    var description: String
    
    static var types: [PerfumeColor] = [
        PerfumeColor(name: "Fruity Florals", hexValue: "EC3C3C", description: "Fruity Florals is ..."),
        PerfumeColor(name: "Warm & Sweet Gourmands", hexValue: "A11818", description: "Warm & Sweet Gourmands is ..."),
        PerfumeColor(name: "Warm Florals", hexValue: "E26262", description: "Warm Florals is ..."),
        PerfumeColor(name: "Warm Woods", hexValue: "895151", description: "Warm Woods is ..."),
        PerfumeColor(name: "Fresh Florals", hexValue: "FF9680", description: "Fresh Florals is ..."),
        PerfumeColor(name: "Fresh Citrus & Fruits", hexValue: "FCE182", description: "Fresh Citrus & Fruits is ..."),
        PerfumeColor(name: "Classic Florals", hexValue: "EC96E3", description: "Classic Florals is ..."),
        PerfumeColor(name: "Woody Spices", hexValue: "513737", description: "Woody Spices is ..."),
        PerfumeColor(name: "Cool Spices", hexValue: "326D98", description: "Cool Spices is ..."),
        PerfumeColor(name: "Classic Woods", hexValue: "595252", description: "Classic Woods is ..."),
        PerfumeColor(name: "Citrus & Woods", hexValue: "B2A795", description: "Citrus & Woods is ..."),
        PerfumeColor(name: "Fresh Solar", hexValue: "F0BC00", description: "Fresh Solar is ..."),
        PerfumeColor(name: "Warm & Sheer", hexValue: "B8B0B0", description: "Warm & Sheer is ..."),
        PerfumeColor(name: "Powdery Florals", hexValue: "D933C7", description: "Powdery Florals is ..."),
        PerfumeColor(name: "Fresh Aquatics", hexValue: "2C5DDA", description: "Fresh Aquatics is ..."),
        PerfumeColor(name: "Earthy Greens & Herbs", hexValue: "4B9A4E", description: "Earthy Greens & Herbs is ...")
    ]
    
    /*
    static var types: [PerfumeColor] = [
        PerfumeColor(name: "Fruity Florals", hexValue: "EC3C3C", desc: ["Fruity Florals is ..."]),
        PerfumeColor(name: "Warm & Sweet Gourmands", hexValue: "A11818", desc: ["Warm & Sweet Gourmands is ..."]),
        PerfumeColor(name: "Warm Florals", hexValue: "E26262", desc: ["Warm Florals is ..."]),
        PerfumeColor(name: "Warm Woods", hexValue: "895151", desc: ["Warm Woods is ..."]),
        PerfumeColor(name: "Fresh Florals", hexValue: "FF9680", desc: ["Fresh Florals is ..."]),
        PerfumeColor(name: "Fresh Citrus & Fruits", hexValue: "FCE182", desc: ["Fresh Citrus & Fruits is ..."]),
        PerfumeColor(name: "Classic Florals", hexValue: "EC96E3", desc: ["Classic Florals is ..."]),
        PerfumeColor(name: "Woody Spices", hexValue: "513737", desc: ["Woody Spices is ..."]),
        PerfumeColor(name: "Cool Spices", hexValue: "326D98", desc: ["Cool Spices is ..."]),
        PerfumeColor(name: "Classic Woods", hexValue: "595252", desc: ["Classic Woods is ..."]),
        PerfumeColor(name: "Citrus & Woods", hexValue: "B2A795", desc: ["Citrus & Woods is ..."]),
        PerfumeColor(name: "Fresh Solar", hexValue: "F0BC00", desc: ["Fresh Solar is ..."]),
        PerfumeColor(name: "Warm & Sheer", hexValue: "B8B0B0", desc: ["Warm & Sheer is ..."]),
        PerfumeColor(name: "Powdery Florals", hexValue: "D933C7", desc: ["Powdery Florals is ..."]),
        PerfumeColor(name: "Fresh Aquatics", hexValue: "2C5DDA", desc: ["Fresh Aquatics is ..."]),
        PerfumeColor(name: "Earthy Greens & Herbs", hexValue: "4B9A4E", desc: ["Earthy Greens & Herbs is ..."])
    ]
     */
    
    //  -----------------
//
//
//    /*
//    static var types: [PerfumeColor] = [
//        PerfumeColor(name: "Fruity Florals", hexValue: "EC3C3C"),
//        PerfumeColor(name: "Warm & Sweet Gourmands", hexValue: "A11818"),
//        PerfumeColor(name: "Warm Florals", hexValue: "E26262"),
//        PerfumeColor(name: "Warm Woods", hexValue: "895151"),
//        PerfumeColor(name: "Fresh Florals", hexValue: "FF9680"),
//        PerfumeColor(name: "Fresh Citrus & Fruits", hexValue: "FCE182"),
//        PerfumeColor(name: "Classic Florals", hexValue: "EC96E3"),
//        PerfumeColor(name: "Woody Spices", hexValue: "513737"),
//        PerfumeColor(name: "Cool Spices", hexValue: "326D98"),
//        PerfumeColor(name: "Classic Woods", hexValue: "595252"),
//        PerfumeColor(name: "Citrus & Woods", hexValue: "B2A795"),
//        PerfumeColor(name: "Fresh Solar", hexValue: "F0BC00"),
//        PerfumeColor(name: "Warm & Sheer", hexValue: "B8B0B0"),
//        PerfumeColor(name: "Powdery Florals", hexValue: "D933C7"),
//        PerfumeColor(name: "Fresh Aquatics", hexValue: "2C5DDA"),
//        PerfumeColor(name: "Earthy Greens & Herbs", hexValue: "4B9A4E")
//    ]
//     */
//
//    static var descs: [PerfumeColor] = [
//        PerfumeColor(name: "", hexValue: "", description: ["Fruity Florals is ..."]),
//        PerfumeColor(name: "", hexValue: "", description: ["Warm & Sweet Gourmands is ..."]),
//        PerfumeColor(name: "", hexValue: "", description: ["Warm Florals is ..."]),
//        PerfumeColor(name: "", hexValue: "", description: ["Warm Woods is ..."]),
//        PerfumeColor(name: "", hexValue: "", description: ["Fresh Florals is ..."]),
//        PerfumeColor(name: "", hexValue: "", description: ["Fresh Citrus & Fruits is ..."]),
//        PerfumeColor(name: "", hexValue: "", description: ["Classic Florals is ..."]),
//        PerfumeColor(name: "", hexValue: "", description: ["Woody Spices is ..."]),
//        PerfumeColor(name: "", hexValue: "", description: ["Cool Spices is ..."]),
//        PerfumeColor(name: "", hexValue: "", description: ["Classic Woods is ..."]),
//        PerfumeColor(name: "", hexValue: "", description: ["Citrus & Woods is ..."]),
//        PerfumeColor(name: "", hexValue: "", description: ["Fresh Solar is ..."]),
//        PerfumeColor(name: "", hexValue: "", description: ["Warm & Sheer is ..."]),
//        PerfumeColor(name: "", hexValue: "", description: ["Powdery Florals is ..."]),
//        PerfumeColor(name: "", hexValue: "", description: ["Fresh Aquatics is ..."]),
//        PerfumeColor(name: "", hexValue: "", description: ["Earthy Greens & Herbs is ..."])
//    ]
//
//    static let elements: [PerfumeColor] = [
//        PerfumeColor(name: "Fruity Florals", hexValue: "EC3C3C", description: descs[0].description[0]),
//        PerfumeColor(name: "Warm & Sweet Gourmands", hexValue: "A11818", description: descs[1].description[1]),
//        PerfumeColor(name: "Warm Florals", hexValue: "E26262", description: descs[2].description[2]),
//        PerfumeColor(name: "Warm Woods", hexValue: "895151", description: descs[3].description[3]),
//        PerfumeColor(name: "Fresh Florals", hexValue: "FF9680", description: descs[4].description[4]),
//        PerfumeColor(name: "Fresh Citrus & Fruits", hexValue: "FCE182", description: descs[5].description[5]),
//        PerfumeColor(name: "Classic Florals", hexValue: "EC96E3", description: descs[6].description[6]),
//        PerfumeColor(name: "Woody Spices", hexValue: "513737", description: descs[7].description[7]),
//        PerfumeColor(name: "Cool Spices", hexValue: "326D98", description: descs[8].description[8]),
//        PerfumeColor(name: "Classic Woods", hexValue: "595252", description: descs[9].description[9]),
//        PerfumeColor(name: "Citrus & Woods", hexValue: "B2A795", description: descs[10].description[10]),
//        PerfumeColor(name: "Fresh Solar", hexValue: "F0BC00", description: descs[11].description[11]),
//        PerfumeColor(name: "Warm & Sheer", hexValue: "B8B0B0", description: descs[12].description[12]),
//        PerfumeColor(name: "Powdery Florals", hexValue: "D933C7", description: descs[13].description[13]),
//        PerfumeColor(name: "Fresh Aquatics", hexValue: "2C5DDA", description: descs[14].description[14]),
//        PerfumeColor(name: "Earthy Greens & Herbs", hexValue: "4B9A4E", description: descs[15].description[15])
//    ]
}
