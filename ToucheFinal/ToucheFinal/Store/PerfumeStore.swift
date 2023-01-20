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
    let path = Firestore.firestore()
    
    init() {
        read()
    }
    
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
}
