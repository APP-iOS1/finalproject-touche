//
//  PerfumeStore.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/17.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
/// 우선순위 정하기
///
/// 1. PerfumeStore CRUD -> Read, (Create, Update, Delete)
///     - read : getDocumets( ) : 1번 불러오기 vs addSnapListner( ) : 변화있을때마다 새로 불러와줌. / 김태형, 김태성
///             > 일반 addSnapshotListener 써도 무방하다. [https://fomaios.tistory.com/entry/Firebase-addSnapshotListener-%ED%9A%A8%EC%9C%A8%EC%A0%81%EC%9C%BC%EB%A1%9C-%EC%82%AC%EC%9A%A9%ED%95%98%EA%B8%B0](https://fomaios.tistory.com/entry/Firebase-addSnapshotListener-%ED%9A%A8%EC%9C%A8%EaC%A0%81%EC%9C%BC%EB%A1%9C-%EC%82%AC%EC%9A%A9%ED%95%98%EA%B8%B0)
///     - paging : 한번에 몇개가져올지? / 홍진표
///             > 아직 미완료
///     - 복합 query: 어떤 기준으로 필터링해서 데이터를 불러올지? / 서광현
///             > 필터링은 서버단에서 해도 가능하다. / 복합 인덱스를 설정하는 이슈가 있는데, 파이어스토어에서 콘솔로 안내해준다.
/// 2. Log-in
///     - 해결 : UserInfoStore

class PerfumeStore: ObservableObject {
    @Published var perfumes: [Perfume] = []
    @Published var topComment20Perfumes: [Perfume] = []
    @Published var recentlyViewed7Perfumes: [Perfume] = []
    @Published var recentlyViewedPerfumeIds: [String] = []
    let path = Firestore.firestore()
    
//    init() {
//        read()
//    }
    
    var listener: ListenerRegistration?
    
    func read() {
        self.listener = path.collection("Perfume")
            .addSnapshotListener { [weak self] snapshot, _ in
                guard let snapshot = snapshot else { return }
                self?.perfumes = snapshot.documents.compactMap { query -> Perfume? in
                    do {
                        return try query.data(as: Perfume.self)
                    } catch {
                        return nil
                    }
                }
            }
    }
    
    func readTopComment20Perfumes() {
        self.listener = path.collection("Perfume").order(by: "commentCount", descending: true).limit(to: 20)
            .addSnapshotListener { [weak self] snapshot, _ in
                guard let snapshot = snapshot else { return }
                self?.topComment20Perfumes = snapshot.documents.compactMap { query -> Perfume? in
                    do {
                        return try query.data(as: Perfume.self)
                    } catch {
                        return nil
                    }
                }
            }
    }
    
    func readRecentlyViewd7Perfumes() {
        self.listener = path.collection("Perfume").limit(to: 7)
            .addSnapshotListener { [weak self] snapshot, _ in
                guard let snapshot = snapshot else { return }
                self?.recentlyViewed7Perfumes = snapshot.documents.compactMap { query -> Perfume? in
                    do {
                        return try query.data(as: Perfume.self)
                    } catch {
                        return nil
                    }
                }
            }
    }
    
    func readUserInfo() {
        self.listener = path.collection("TestUser").document("태형Id")
            .addSnapshotListener { [weak self] snapshot, _ in
                guard let snapshot = snapshot else { return }
                let docData = snapshot.data()
                let id = snapshot.documentID
                let recentlyViewedPerfumeIds: [String] = docData?["recentlyViewedPerfumeIds"] as? [String] ?? []
                self?.recentlyViewedPerfumeIds = recentlyViewedPerfumeIds
                print(self?.recentlyViewedPerfumeIds)
                print(recentlyViewedPerfumeIds)
            }
    }
    
    func readRecentlyViewd7Perfumesss(recentlyViewedPerfumeIds: [String]) {
//        var recentlyViewedPerfumeIds: [String] = ["P12495", "P12420", "P138300"]
        var arr: [Perfume] = []
        
        self.listener = path.collection("Perfume")
            .whereField("perfumeId", in: recentlyViewedPerfumeIds).limit(to: 7)
            .addSnapshotListener { [weak self] snapshot, _ in
                guard let snapshot = snapshot else { return }
                arr = snapshot.documents.compactMap { query -> Perfume? in
                    do {
                        return try query.data(as: Perfume.self)
                    } catch {
                        return nil
                    }
                }
                self?.recentlyViewed7Perfumes.removeAll()
                for id in recentlyViewedPerfumeIds {
                    for perfume in arr {
                        if perfume.perfumeId == id {
                            self?.recentlyViewed7Perfumes.append(perfume)
                        }
                    }
                }
            }
    }
                    
        //        for id in recentlyViewedPerfumeIds {
//                path.collection("Perfume").whereField("perfumeId", in: recentlyViewedPerfumeIds)
//                    .addSnapshotListener { document, error in
//
//                        guard let document else { return }

//                for doc in document.documents {
//                    let id = doc.documentID
//                    let docData = doc.data()
//                    let brandName: String = docData["brandName"] as? String ?? ""
//                    let commentCount: Int = docData["commentCount"] as? Int ?? 0
//                    let displayName: String = docData["displayName"] as? String ?? ""
//                    let fragranceDescription: String = docData["fragranceDescription"] as? String ?? ""
//                    let fragranceFamily: String = docData["fragranceFamily"] as? String ?? ""
//                    let heroImage: String = docData["heroImage"] as? String ?? ""
//                    let image450: String = docData["image450"] as? String ?? ""
//                    let keyNotes: [String] = docData["keyNotes"] as? [String] ?? []
//                    let likedPeople: [String] = docData["likedPeople"] as? [String] ?? []
//                    let scentType: String = docData["scentType"] as? String ?? ""
//                    let totalPerfumeScore: Int = docData["totalPerfumeScore"] as? Int ?? 0
//
//                    var perfume = Perfume(perfumeId: id, brandName: brandName, displayName: displayName, heroImage: heroImage, image450: image450, fragranceFamily: fragranceFamily, scentType: scentType, keyNotes: keyNotes, fragranceDescription: fragranceDescription, likedPeople: likedPeople, commentCount: commentCount, totalPerfumeScore: totalPerfumeScore)
//
//                    self.recentlyViewd7Perfumes.append(perfume)
//                }
//            }
//        }
        
//        self.listener = path.collection("Perfume")
//            .whereField("perfumeId", arrayContainsAny: recentlyViewedPerfumeIds).limit(to: 7)
//            .addSnapshotListener { [weak self] snapshot, _ in
//                guard let snapshot = snapshot else { return }
//                self?.recentlyViewd7Perfumes = snapshot.documents.compactMap { query -> Perfume? in
//                    do {
//                        return try query.data(as: Perfume.self)
//                    } catch {
//                        return nil
//                    }
//                }
//            }
//    }
    
    func createRecentlyViewedPerfume(perfume: Perfume) {
        let createdAt = Date().timeIntervalSince1970
        path.collection("TestUser").document("태형Id").collection("RecentlyViewedPerfume").document(perfume.perfumeId)
            .setData([
                "perfumeId": perfume.perfumeId,
                "createdAt": createdAt])
    }
    
//    func readRecentlyViewed7Perfumes() {
//        self.listener = path.collection("User")
//            .addSnapshotListener { [weak self] snapshot, _ in
//                guard let snapshot = snapshot else { return }
//                self?.topComment20Perfumes = snapshot.documents.compactMap { query -> Perfume? in
//                    do {
//                        return try query.data(as: Perfume.self)
//                    } catch {
//                        return nil
//                    }
//                }
//            }
//    }
    
    func detach() {
        listener?.remove()
    }
    
    func create(perfume: Perfume) {
        do {
           try path.collection("Perfume").document(perfume.perfumeId)
                .setData(from: perfume)
        } catch {
            return
        }
        
    }
    func update(perfume: Perfume) {
        path.collection("Perfume").document(perfume.perfumeId)
            .updateData([:])
    }
    func delete(perfume: Perfume) {
        path.collection("Perfume").document(perfume.perfumeId)
            .delete()
    }
}
