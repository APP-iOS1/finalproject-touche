//
//  CommentStore.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/17.
//

import Foundation
import FirebaseFirestore

class CommentStore: ObservableObject {
    let database = Firestore.firestore().collection("Perfume")
    
//    func fetchComments(perfumeId: String) {
//        var tempComments: [Comment] = []
//        database.document(perfumeId).collection("Comment")
//            .getDocuments { (snapshot, error) in
//                tempComments.removeAll()
//                if let snapshot {
//                    for document in snapshot.documents{
//                        let docData = document.data()
//                        let id: String = document.documentID
//                        let commentContent: String = docData["commentContent"] as? String ?? ""
//                        let createdAt: Double = docData["createdAt"] as? Double ?? 0
//                        let userID: String = docData["userID"] as? String ?? ""
//                        let userNickName: String = docData["userNickName"] as? String ?? ""
//                        
//                        let comment: Comment = Comment(id: id, commentContent: commentContent, createdAt: createdAt, userID: userID, userNickName: userNickName)
//                        
//                        self.tempComments.append(comment)
//                        
//                        let commentId: String = docData["commentContent"] as? String ?? ""
//                        let commentTime: String = docData["commentContent"] as? String ?? ""
//                        let contents: String = docData["commentContent"] as? String ?? ""
//                        let perfumeScore: Int = docData["commentContent"] as? Int ?? 0
//                        let writerId: String = docData["commentContent"] as? String ?? ""
//                        let writerNickName: String = docData["commentContent"] as? String ?? ""
//                        let writerImage: String = docData["commentContent"] as? String ?? ""
//                    }
//                }
//            }
//    }
    
}
