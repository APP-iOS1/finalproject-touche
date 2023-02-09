//
//  PerfumeStore.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/17.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

@MainActor
class PerfumeStore: ObservableObject {
    
    @Published var recomendedPerfumes: [Perfume] = []
    @Published var topComment20Perfumes: [Perfume] = []
    @Published var recentlyViewedPerfumes: [Perfume] = []
    @Published var SelectedScentTypePerfumes: [Perfume] = []
    @Published var likedPerfumes: [Perfume] = []

    @Published var recentSearches: [String] = []
    // 검색 할때 브랜드 또는 향수 텍스트 나올지 판단 변수
    @Published var isShowingBrandText = false
    @Published var isShowingPerfumeText = false
    
    let database = Firestore.firestore().collection("Perfume")
    
    func readRecomendedPerfumes(perfumesId: [String]) async {
        do {
            var tempPerfumes: [Perfume] = []
            let snapshot = try await database.whereField("scentType", in: perfumesId).getDocuments()
            for document in snapshot.documents {
                let perfume =  try document.data(as: Perfume.self)
                tempPerfumes.append(perfume)
            }
            recomendedPerfumes = Array(Set(tempPerfumes))
        } catch {}
    }
    
    func readRecentlyPerfumes(perfumesId: [String]) async {
        do {
            var tempPerfumes: [Perfume] = []
            let snapshot = try await database.whereField("perfumeId", in: perfumesId ).getDocuments()
            for document in snapshot.documents {
                let perfume =  try document.data(as: Perfume.self)
                tempPerfumes.append(perfume)
            }
            if !tempPerfumes.isEmpty {
                for perfumeId in perfumesId.reversed() {
                    tempPerfumes.insert(tempPerfumes.filter{$0.perfumeId == perfumeId}[0], at: 0)
                }
            }
            recentlyViewedPerfumes = Array(tempPerfumes.prefix(min(tempPerfumes.count / 2, 7)))
            
        } catch {}
    }
    
    func readSelectedScentTypePerfumes(scentType: String) async {
        do {
            var tempPerfumes: [Perfume] = []
            let snapshot = try await database.whereField("scentType", isEqualTo: scentType).getDocuments()
            for document in snapshot.documents {
                let perfume =  try document.data(as: Perfume.self)
                tempPerfumes.append(perfume)
            }
            SelectedScentTypePerfumes = Array(Set(tempPerfumes))
        } catch {}
    }
    
        
    func readLikedPerfumes(userId: String) async {
        do {
            var tempPerfumes: [Perfume] = []
            let snapshot = try await database.whereField("likedPeople",arrayContains: userId).getDocuments()
            for document in snapshot.documents {
                let perfume =  try document.data(as: Perfume.self)
                tempPerfumes.append(perfume)
            }
            likedPerfumes = tempPerfumes.sorted {$0.likedPeople.count > $1.likedPeople.count}
        } catch {}
    }
    
    func addLikePerfume(perfume: Perfume, userId: String) async {
        do {
            try await database.document(perfume.perfumeId)
                .updateData([
                    "likedPeople": FieldValue.arrayUnion([userId])
                ])
        } catch {}
        
    }
    
    func deleteLikePerfume(perfume: Perfume, userId: String) async {
        do {
            try await database.document(perfume.perfumeId)
                .updateData([
                    "likedPeople": FieldValue.arrayRemove([userId])
                ])
        } catch {}
        
    }
    
    func updateCommentCount(perfumeId: String, score: Int) async {
        do {
            let perfume = await fetchPerfume(perfumeId: perfumeId)
            try await database.document(perfume.perfumeId)
                .updateData([
                    "commentCount": (perfume.commentCount + 1),
                    "totalPerfumeScore": (perfume.totalPerfumeScore + score)
                ])
        } catch {}
    }
    
    func fetchPerfume(perfumeId: String) async -> Perfume {
        var perfume: [Perfume] = []
        do {
            let snapshot = try await database.document(perfumeId).getDocument()
            perfume.append(try snapshot.data(as: Perfume.self))
        } catch {}
        return perfume[0]
    }
    
    func deletePerfumeComment(perfumeId: String, score: Int) async {
        do {
            let perfume = await fetchPerfume(perfumeId: perfumeId)
            try await database.document(perfume.perfumeId)
                .updateData([
                    "commentCount": (perfume.commentCount - 1),
                    "totalPerfumeScore": (perfume.totalPerfumeScore - score)
                ])
        } catch {}
    }
}
