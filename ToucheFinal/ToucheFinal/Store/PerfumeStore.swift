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
    
    
    //MARK: - 최근 댓글 많은 순 20개 향수 보여주기
    /// 향수 콜렉션 안의 향수들을 commentCount 값으로 정렬한 후
    /// 20개의 데이터를 받아온 후 topComment20Perfumes 배열에 넣어준다.
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
    
    //MARK: - 최근 본 뷰에 향수의 id값 추가하기
    /// 향수 디테일뷰로 넘어갈 때 마다 향수의 id값을 user의 정보에 담아주는 메소드
    /// 이 후 향수 id 배열은 Perfume collection에서 쿼리에 사용된다.
    func createRecentlyViewedPerfume(perfume: Perfume) {
        //        let createdAt = Date().timeIntervalSince1970
        // 로그인 분기처리되면 document의 id값을 유저id로 수정 예정
        path.collection("TestUser").document("태형Id")
            .updateData([
                "recentlyViewedPerfumeIds": FieldValue.arrayUnion([perfume.perfumeId])
            ])
    }
    
    //MARK: - 최근 본 향수의 id값이 유저정보에 담기면 Read + func fetchRecentlyViewd7Perfumes
    func readViewedPerfumeIdsArrayAtUserInfo() {
        self.listener = path.collection("TestUser").document("태형Id")
            .addSnapshotListener { [weak self] snapshot, _ in
                guard let snapshot = snapshot else { return }
                let docData = snapshot.data()
                self?.recentlyViewedPerfumeIds = docData?["recentlyViewedPerfumeIds"] as? [String] ?? []
                

                self?.fetchRecentlyViewd7Perfumes(recentlyViewedPerfumeIds: self?.recentlyViewedPerfumeIds ?? [])
            }
    }
    
    //MARK: - 유저정보에 담긴 최근 본 향수의 id값을 받아와서 퍼퓸 컬렉션에서 해당하는 퍼퓸들을 배열에 담아 보여줌
    func fetchRecentlyViewd7Perfumes(recentlyViewedPerfumeIds: [String]) {
        path.collection("Perfume")
//            .whereField("perfumeId", in: recentlyViewedPerfumeIds).limit(to: 7)
            .getDocuments {
                snapshot, error in
                guard let snapshot = snapshot else { return }
                var arr: [Perfume] = []
                arr = snapshot.documents.compactMap { query -> Perfume? in
                    do {
                        return try query.data(as: Perfume.self)
                    } catch {
                        return nil
                    }
                }
                
                self.recentlyViewed7Perfumes.removeAll()
                for id in recentlyViewedPerfumeIds {
                    for perfume in arr {
                        if perfume.perfumeId == id {
                            self.recentlyViewed7Perfumes.insert(perfume, at: 0)
                        }
                    }
                }
            }
    }
    

}
