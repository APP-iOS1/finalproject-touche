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
    var createdDate: Date
    var perfumeIds: [String]
}

///// dummy data
//var dummyMagazines = [
//        Magazine(id: UUID().uuidString, title: "CHANEL N°5\nFor the first time", subTitle: "beginning with the revolutionary moment of its creation", contentImage: "https://firebasestorage.googleapis.com:443/v0/b/touchefinal-231b4.appspot.com/o/magazine%2F9C54F7C7-C686-4C94-9D0B-955172F6D00A%2FcontentImage?alt=media&token=4d275e5f-bd4e-4be7-9d4f-2ff96562f662", bodyImage: "https://firebasestorage.googleapis.com:443/v0/b/touchefinal-231b4.appspot.com/o/magazine%2F9C54F7C7-C686-4C94-9D0B-955172F6D00A%2FbodyImage?alt=media&token=879c8f1a-6564-49b3-bb55-f56cc31b4fdb", createdDate: 0, perfumeIds: ["P404758", "P138300", "P257900", "P36680", "P385350", "P392141", "P393151", "P394534", "P395313", "P410469"]),
//        Magazine(id: UUID().uuidString, title: "Top Seller \nPerfume’s History", subTitle: "Learn SwiftUI, React and UI Design", contentImage: "https://firebasestorage.googleapis.com:443/v0/b/touchefinal-231b4.appspot.com/o/magazine%2F0ED398D0-168D-47F4-B991-81BFB515236E%2FcontentImage?alt=media&token=462acd30-254f-486b-9c8d-804cbf4f915b", bodyImage: "https://firebasestorage.googleapis.com:443/v0/b/touchefinal-231b4.appspot.com/o/magazine%2FFB6D70F3-C4FC-4C87-B49B-8E91DA50F5D8%2FcontentImage?alt=media&token=63f3d789-1e1b-4ab6-8b81-9c5a9b683aff", createdDate: 0, perfumeIds: ["P12420", "P12495"]),
//        Magazine(id: UUID().uuidString, title: "Top Seller \nPerfume’s History", subTitle: "Learn SwiftUI, React and UI Design", contentImage: "https://firebasestorage.googleapis.com:443/v0/b/touchefinal-231b4.appspot.com/o/magazine%2FFB6D70F3-C4FC-4C87-B49B-8E91DA50F5D8%2FcontentImage?alt=media&token=63f3d789-1e1b-4ab6-8b81-9c5a9b683aff", bodyImage: "https://firebasestorage.googleapis.com:443/v0/b/touchefinal-231b4.appspot.com/o/magazine%2FFB6D70F3-C4FC-4C87-B49B-8E91DA50F5D8%2FbodyImage?alt=media&token=9155f1a5-45fa-4715-897a-3d693f6a03ca", createdDate: 0, perfumeIds: ["P12420", "P12495"])
//
//]

let dummyWithOtherProjectFirebaseStorage = [
    Magazine(id: UUID().uuidString,
             title: "CHANEL N°5 For the first time",
             subTitle: "beginning with the revolutionary moment of its creation",
             contentImage: "https://firebasestorage.googleapis.com/v0/b/fir-authpractice-cc33b.appspot.com/o/magazine%2F78057DB7-4C07-4025-A22D-A07A8A69545B%2FcontentImage.jpeg?alt=media&token=4e970107-e9ef-479e-b4ee-49f947de04ea",
             bodyImage: "https://firebasestorage.googleapis.com/v0/b/fir-authpractice-cc33b.appspot.com/o/magazine%2F78057DB7-4C07-4025-A22D-A07A8A69545B%2FbodyImage.jpeg?alt=media&token=40b6992f-ce59-461c-8543-e946d14e99a0",
             createdDate: Date(),
             perfumeIds: ["P12481", "P412038"]),
    
    Magazine(id: UUID().uuidString,
             title: "Personal Perfume Recommendation ",
             subTitle: "Recommendations learned from Brand Le Labo",
             contentImage: "https://firebasestorage.googleapis.com/v0/b/fir-authpractice-cc33b.appspot.com/o/magazine%2F2328CBBB-39A9-45CB-B22F-CC488E10C7D5%2FcontentImage.jpeg?alt=media&token=2ab384cb-5cf6-4551-a690-df3a8fd361ad",
             bodyImage: "https://firebasestorage.googleapis.com/v0/b/fir-authpractice-cc33b.appspot.com/o/magazine%2F2328CBBB-39A9-45CB-B22F-CC488E10C7D5%2FbodyImage.jpeg?alt=media&token=92ebb009-2054-47d2-a9f8-53268fc0397d",
             createdDate: Date(),
             perfumeIds: ["P404758", "P138300", "P257900", "P394534"]),
    
    Magazine(id: UUID().uuidString,
             title: "Luxury from Sweden, Byredo",
             subTitle: "From perfume to hair mist",
             contentImage: "https://firebasestorage.googleapis.com/v0/b/fir-authpractice-cc33b.appspot.com/o/magazine%2F49A7267E-C0AD-494B-95EC-860586E9CED5%2FcontentImage.jpg?alt=media&token=3b374784-daa7-40fd-ba86-acd14f3d5091",
             bodyImage: "https://firebasestorage.googleapis.com/v0/b/fir-authpractice-cc33b.appspot.com/o/magazine%2F49A7267E-C0AD-494B-95EC-860586E9CED5%2FbodyImage.jpeg?alt=media&token=531baec8-3976-4f72-a8a8-4bb92c096854",
             createdDate: Date(),
             perfumeIds: ["P385350", "P385358", "P404758","P427008"])
    
]
