//
//  PerfumeColor.swift
//  ToucheFinal
//
//  Created by james seo on 2023/01/30.
//
import Foundation
import SwiftUI

struct PerfumeColor: Identifiable, Hashable {
    var id = UUID().uuidString

    var name: String
    var hexValue: String
    var color: Color {
        Color(hex: hexValue) ?? Color.clear
    }
    var description: [String]?

    static var types: [PerfumeColor] = [
        PerfumeColor(name: "Warm & Sweet Gourmands", hexValue: "A11818", description: ["A gourmand fragrance is a perfume consisting primarily of synthetic edible (gourmand) notes, such as honey, chocolate, vanilla or candy. These top and middle notes may be blended with non-edible base notes such as patchouli or musk. They have been described as olfactory desserts."]),

        PerfumeColor(name: "Fruity Florals", hexValue: "EC3C3C", description: ["A 'contemporary' spin on the floral family, fruity florals have become incredibly popular in the past 10 years: sunny in nature, with a young, spirited joie de vivre. The juicy fruits – like peach, raspberry, mango, pear and apple – add luscious sweetness to cut flowers."]),
        
        PerfumeColor(name: "Powdery Florals", hexValue: "D933C7", description: ["Consider the smell (and feel!) of facial, baby, or talcum powder. Most people associate powdery perfumes with luxury, sophistication and seduction thanks to its musky and soft floral combinations. Usually powdery notes are iris/orris, violet, vanilla, rose, musks, heliotrope, opoponax resin and amber."]),
        
        PerfumeColor(name: "Classic Florals", hexValue: "EC96E3", description: ["Floral perfumes are packed with flowers we all know and love such as rose, jasmine, iris and lily making them the ultimate feminine scent."]),
        
        PerfumeColor(name: "Warm Florals", hexValue: "E26262", description: ["Floral perfumes are packed with flowers we all know and love such as rose, jasmine, iris and lily making them the ultimate feminine scent. It gives a more subtle feeling than Classic floral type, so it's good to spray on a daily basis."]),
        
        PerfumeColor(name: "Fresh Florals", hexValue: "FF9680", description: ["Some bright examples of light floral scents are rose, peony, geranium and tuberose (by the way these are the so called “rose florals”), as well as violet, lily, hyacinth, bluebell and lilac (the “lily-florals”). It has the lightest color among the floral types."]),
        
        PerfumeColor(name: "Fresh Citrus & Fruits", hexValue: "FCE182", description: ["Fresh, zesty, clean—citrus fragrances are a classic for a reason. Fresh, fruity, and enduring, citrus fragrances make up some of the best fragrances of all time. And although their light quality makes them especially nice to spritz on during spring and summer, a great citrus perfume can be worn anytime of year."]),
        
        PerfumeColor(name: "Fresh Solar", hexValue: "F0BC00", description: ["Solar fragrances are exactly what they sound like—they evoke sun-drenched, golden days spent outside. These fragrances don't fit neatly into a box, as they borrow notes from other fragrance families to create warm, sunny scents, so many of them smell very different from each other."]),
        
        PerfumeColor(name: "Earthy Greens & Herbs", hexValue: "4B9A4E", description: ["Green fragrances feature fresh and lively notes that evoke freshly cut grass or stems, green leaves (like violet leaf), foliage, mosses, green tea or other green vegetal scents. This family of fragrances started appearing after WWII."]),
        
        PerfumeColor(name: "Cool Spices", hexValue: "326D98", description: ["They have a spicy, warm, complex scent that is a blend of nutmeg, cloves and cinnamon. These perfumes have been made with chilli pepper berries: Mitsouko Guerlain. Burning Pepper L'Artisan Parfumeur."]),
        
        PerfumeColor(name: "Fresh Aquatics", hexValue: "2C5DDA", description: ["The embodiment of refreshment, aquatic perfumes are scents that take inspiration from water, in particular the ocean. Evoking the freshness and natural elements of the sea breeze, refreshing and crisp."]),
        
        PerfumeColor(name: "Warm Woods", hexValue: "895151", description: ["Fragrances that are dominated by woody scents typically contain Sandalwood, Pine, Patchouli, Vetiver and Cedarwood. Sandalwood is creamy and sensual, Patchouli is like a deep woodland, Vetiver is smoky and rich, Cedarwood is dry and linear and Oudh is complex and heavy."]),
        
        PerfumeColor(name: "Classic Woods", hexValue: "595252", description: ["Fragrances that are dominated by woody scents typically contain Sandalwood, Pine, Patchouli, Vetiver and Cedarwood. Sandalwood is creamy and sensual, Patchouli is like a deep woodland, Vetiver is smoky and rich, Cedarwood is dry and linear and Oudh is complex and heavy. Because it is the most classic in the wood family, it has the heaviest weight."]),
        
        PerfumeColor(name: "Woody Spices", hexValue: "513737", description: ["Woody flavoring, which is typically considered masculine, has a strong presence with strong spices. It represents strong persistence and masculinity."]),
        
        PerfumeColor(name: "Citrus & Woods", hexValue: "B2A795", description: ["Fragrances that are dominated by woody scents typically contain Sandalwood, Pine, Patchouli, Vetiver and Cedarwood. Sandalwood is creamy and sensual, Patchouli is like a deep woodland, Vetiver is smoky and rich, Cedarwood is dry and linear and Oudh is complex and heavy. It is mixed with fresh citrus and can be used by many people regardless of gender."]),
        
        PerfumeColor(name: "Warm & Sheer", hexValue: "B8B0B0", description: ["Scent Sheer by CoSTUME NATIONAL is a Amber Floral fragrance for women. Scent Sheer was launched in 2003. The nose behind this fragrance is Laurent Bruyere. Top notes are Green Tea, Apricot and Bergamot; middle notes are Jasmine, Hibiscus and Rose; base notes are Musk, White Amber, Patchouli and Vanilla. It is very warm and has characteristics similar to the smell of flesh."])
    ]
}
