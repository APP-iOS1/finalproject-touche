//
//  Magazine.swift
//  Magazine
//
//  Created by TAEHYOUNG KIM on 2023/02/08.
//

import Foundation

struct Magazine: Codable, Identifiable {
    var id: String
    var title: String
    var subTitle: String
    var contentImage: String
    var bodyImage: String
    var createdDate: Double
    var perfumeIds: [String]
}

/// dummy data
//var magazines = [
//        Magazine(id: UUID().uuidString, title: "Dog is love why and how your dog loves you", subTitle: "Lear SwiftUI, React and UI Design", contentImage: "image2", bodyImage: "bodyImage", createdDate: 0, perfumeIds: ["P404758", "P138300", "P257900", "P36680", "P385350", "P392141", "P393151", "P394534", "P395313", "P410469"]),
//        Magazine(id: UUID().uuidString, title: "Top Seller \nPerfume’s History", subTitle: "Learn SwiftUI, React and UI Design", contentImage: "image1", bodyImage: "bodyImage", createdDate: 0, perfumeIds: ["P12420", "P12495"])
//]
