//
//  CommentStore.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/17.
//

import Foundation
import FirebaseFirestore

@MainActor
class CommentStore: ObservableObject {
    @Published var comments: [Comment] = []
    let database = Firestore.firestore().collection("Perfume")
    
    func fetchComments(perfumeId: String) async {
        do {
            var tempComments: [Comment] = []
            let snapshot = try await database.document(perfumeId).collection("Comment").getDocuments()
            for document in snapshot.documents{
                let comment = try document.data(as: Comment.self)
                tempComments.append(comment)
            }
            comments = tempComments
        } catch {}
    }
    
    func setComment(comment: Comment, perfumeId: String) async {
        do {
            try await database.document(perfumeId).collection("Comment").document(comment.commentId)
                .setData([
                    "commentId": comment.commentId,
                    "commentTime": comment.commentTime,
                    "contents": comment.contents,
                    "perfumeScore": comment.perfumeScore,
                    "writerId": comment.writerId,
                    "writerNickName": comment.writerNickName,
                    "writerImage": comment.writerImage,
                    "likedPeople": comment.likedPeople
                ])
        } catch {}
    }
    
    //    func likedComment(userId: String, perfumeId: String) async {
    //        do {
    //            var tempPerfumes: [Perfume] = []
    //            let snapshot = try await database.document(perfumeId).collection("Comment").whereField("likedPeople",arrayContains: userId).getDocuments()
    //            for document in snapshot.documents {
    //                let perfume =  try document.data(as: Perfume.self)
    //                tempPerfumes.append(perfume)
    //            }
    ////            likedPerfumes = tempPerfumes.sorted {$0.likedPeople.count > $1.likedPeople.count}
    //        } catch {}
    //    }
    
    func addLikePerfume(perfumeId: String, commentId: String, userId: String) async {
        do {
            try await database.document(perfumeId).collection("Comment").document(commentId)
                .updateData([
                    "likedPeople": FieldValue.arrayUnion([userId])
                ])
        } catch {}
        
    }
    
    func deleteLikeComment(perfumeId: String, commentId: String, userId: String) async {
        do {
            try await database.document(perfumeId).collection("Comment").document(commentId)
                .updateData([
                    "likedPeople": FieldValue.arrayRemove([userId])
                ])
        } catch {}
        
    }
    
    func fetchComment(perfumeId: String, commentId: String) async -> Comment {
        var comment: [Comment] = []
        do {
            let snapshot = try await database.document(perfumeId).collection("Comment").document(commentId).getDocument()
            comment.append(try snapshot.data(as: Comment.self))
        } catch {}
        return comment[0]
    }
    
    func deleteComment(perfumeId: String, commentId: String) async {
        do {
            try await database.document(perfumeId).collection("Comment").document(commentId)
                .delete()
        } catch {}
    }
}

