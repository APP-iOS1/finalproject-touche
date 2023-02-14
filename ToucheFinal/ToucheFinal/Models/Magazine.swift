//
//  Magazine.swift
//  Magazine
//
//  Created by TAEHYOUNG KIM on 2023/02/08.
//

import SwiftUI

struct Magazine: Codable, Identifiable {
    var id: String
    var title: String
    var subTitle: String
    var contentImage: String
    var bodyImage: String
    var createdDate: Double
    var perfumeIds: [String]
}

///// dummy data
var magazines = [
        Magazine(id: UUID().uuidString, title: "CHANEL N°5\nFor the first time", subTitle: "beginning with the revolutionary moment of its creation", contentImage: "https://firebasestorage.googleapis.com:443/v0/b/touchefinal-231b4.appspot.com/o/magazine%2F9C54F7C7-C686-4C94-9D0B-955172F6D00A%2FcontentImage?alt=media&token=4d275e5f-bd4e-4be7-9d4f-2ff96562f662", bodyImage: "https://firebasestorage.googleapis.com:443/v0/b/touchefinal-231b4.appspot.com/o/magazine%2F9C54F7C7-C686-4C94-9D0B-955172F6D00A%2FbodyImage?alt=media&token=879c8f1a-6564-49b3-bb55-f56cc31b4fdb", createdDate: 0, perfumeIds: ["P404758", "P138300", "P257900", "P36680", "P385350", "P392141", "P393151", "P394534", "P395313", "P410469"]),
        Magazine(id: UUID().uuidString, title: "Top Seller \nPerfume’s History", subTitle: "Learn SwiftUI, React and UI Design", contentImage: "https://firebasestorage.googleapis.com:443/v0/b/touchefinal-231b4.appspot.com/o/magazine%2F0ED398D0-168D-47F4-B991-81BFB515236E%2FcontentImage?alt=media&token=462acd30-254f-486b-9c8d-804cbf4f915b", bodyImage: "bodyImage", createdDate: 0, perfumeIds: ["P12420", "P12495"])
]
