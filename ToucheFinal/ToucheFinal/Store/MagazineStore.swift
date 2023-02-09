//
//  TestMagazine.swift
//  ToucheFinal
//
//  Created by TAEHYOUNG KIM on 2023/02/09.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage

class MagazineStore: ObservableObject {
    @Published var magazineRelatedPerfumes: [Perfume] = []
    @Published var magazines: [Magazine] = []

    let storage = Storage.storage()
    let firestore = Firestore.firestore()
    
    //MARK: - Storage에 사진 업로드 후 Firestore에 매거진 문서 생성
    func createMagazine(magazine: Magazine, selectedContentUImage: UIImage?, selectedBodyUImage: UIImage?) async {
        
        var contentImage: String?
        var bodyImage:String?
        
        let contentImageRef = storage.reference(withPath: "magazine/\(magazine.id)/contentImage")
        guard let selectedContentImage = selectedContentUImage else { return }
        guard let imageData = selectedContentImage.jpegData(compressionQuality: 1.0) else { return }
        do {
            let _ = try await contentImageRef.putDataAsync(imageData)
            let contentImageString = try await contentImageRef.downloadURL()
            print(contentImageString.absoluteString)
            
            contentImage = contentImageString.absoluteString
        } catch {
            print("contentImage upload error")
        }
        
        
        let bodyImageRef = storage.reference(withPath: "magazine/\(magazine.id)/bodyImage")
        guard let selectedBodyImage = selectedBodyUImage else { return }
        guard let imageData = selectedBodyImage.jpegData(compressionQuality: 1.0) else { return }
        do {
            let _ = try await bodyImageRef.putDataAsync(imageData)
            let bodyImageString = try await bodyImageRef.downloadURL()
            print(bodyImageString.absoluteString)
            
            bodyImage = bodyImageString.absoluteString
        } catch {
            print("bodyImage upload error")
        }
        
        guard let bodyImage = bodyImage, let contentImage = contentImage else {return}
        await createMagazineAtFirestore(magazine: magazine, bodyImageString: bodyImage, contentImageString: contentImage)
    }
    
    
    
    //MARK: - Firestore에 매거진 문서 생성
    func createMagazineAtFirestore(magazine: Magazine, bodyImageString: String, contentImageString: String) async {
        do {
            try await firestore.collection("Magazine").document(magazine.id).setData([
                "id": magazine.id,
                "title": magazine.title,
                "subTitle": magazine.subTitle,
                "contentImage": contentImageString,
                "bodyImage": bodyImageString,
                "createdDate": magazine.createdDate,
                "perfumeIds":magazine.perfumeIds
            ])
            print("매거진 생성")
        } catch {
            print("매거진 생성 실패")
        }
    }
    @MainActor
    func readMagazines() async {
        do {
            var tempMagazines: [Magazine] = []
            let snapshot = try await firestore.collection("Magazine").getDocuments()
            for document in snapshot.documents {
                let magazine = try document.data(as: Magazine.self)
                tempMagazines.append(magazine)
            }
            magazines = tempMagazines
        } catch {
            
        }
    }
    @MainActor
    func readMagazineRelatedPerfumes(perfumesId: [String]) async {
        do {
            var tempPerfumes: [Perfume] = []
            let snapshot = try await firestore.collection("Perfume").whereField("perfumeId", in: perfumesId ).getDocuments()
            for document in snapshot.documents {
                let perfume =  try document.data(as: Perfume.self)
                tempPerfumes.append(perfume)
            }
            magazineRelatedPerfumes = tempPerfumes
            
        } catch {}
    }

}
