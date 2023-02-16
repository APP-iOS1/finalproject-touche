//
//  CommentCell.swift
//  ToucheFinal
//
//  Created by 조석진 on 2023/01/18.
//

import SwiftUI
import SDWebImageSwiftUI
 // TODO: - 삭제시 Alert창 추가
struct CommentCell: View {
    @EnvironmentObject var userInfoStore: UserInfoStore
    @EnvironmentObject var commentStore: CommentStore
    @EnvironmentObject var perfumeStore: PerfumeStore
    @State var comment: Comment
    @State var isShowingWriteComment: Bool = false
    @State var deleteAlertActive: Bool = false
    @Binding var perfume: Perfume
    
    var body: some View {
        HStack(alignment: .top){
            if comment.writerImage == "" {
                Image(systemName: "person.fill")
                    .resizable()
                    .padding(6)
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(.gray, lineWidth: 0.1)
                    }
            } else {
                WebImage(url: URL(string: comment.writerImage))
                    .resizable()
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(.gray, lineWidth: 0.1)
                    }
            }
            VStack(alignment: .leading){
                //
                HStack {
                    Text(comment.writerNickName)
                        .font(.subheadline)
                        .fontWeight(.bold)
                    if userInfoStore.user?.uid == comment.writerId {
                        Spacer()
                        
                        Button {
                            isShowingWriteComment = true
                        } label: {
                            Image(systemName: "pencil")
                                
                            
                        }
                        
                        Button {
                            deleteAlertActive.toggle()
                        } label: {
                            Image(systemName: "trash")
                        }
                        
                    }
                }
                .frame(width: 300, alignment: .leading)
                .foregroundColor(.black)
                //
                Text(comment.contents)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .frame(width: 300, alignment: .leading)
                    .offset(y: 5)
                HStack {
                    RatingView(score: .constant(comment.perfumeScore), frame: 13, canClick: false)
                    Button {
                        Task {
                            if userInfoStore.user?.isEmailVerified ?? false {
                                guard let userId = userInfoStore.user?.uid else {return}
                                
                                if comment.likedPeople.contains(userId) {
                                    // 해당 uid 제거
                                    await commentStore.deleteLikeComment(perfumeId: perfume.perfumeId, commentId: comment.commentId, userId: userId)
                                } else {
                                    // 해당 uid 추가
                                    await commentStore.addLikePerfume(perfumeId: perfume.perfumeId, commentId: comment.commentId, userId: userId)
                                }
                            } // if
                                comment = await commentStore.fetchComment(perfumeId: perfume.perfumeId, commentId: comment.commentId)
                        }
                    } label: {
                        Image(systemName: comment.likedPeople.contains(userInfoStore.user?.uid ?? "") ? "hand.thumbsup.fill" : "hand.thumbsup")
                            .resizable()
                            .frame(width: 13, height: 13)
                            .foregroundColor(.black)
                    }
                    Text("\(comment.likedPeople.count)")
                        .font(.system(size: 13))
                        .padding(.leading, -3)
                }
            }
            .alert(
                "Delete"
                ,isPresented: $deleteAlertActive
            ) {
                Button("Cancel", role: .cancel) {}
                Button("Delete", role: .destructive) {
                    Task {
                        await perfumeStore.deletePerfumeComment(perfumeId: perfume.perfumeId, score: comment.perfumeScore)
                        await commentStore.deleteComment(perfumeId: perfume.perfumeId, commentId: comment.commentId)
                        await commentStore.fetchComments(perfumeId: perfume.perfumeId)
                        await userInfoStore.deleteWrittenComment(perfumeId: perfume.perfumeId, commentId: comment.commentId)
                        perfume = await perfumeStore.fetchPerfume(perfumeId: perfume.perfumeId)
                    }
                }
            } message: {
                Text("Are you sure you want to delete the review?")
            }
            .sheet(isPresented: $isShowingWriteComment) {
                WriteCommentView(score: comment.perfumeScore, isShowingWriteComment: $isShowingWriteComment, perfume: $perfume, reviewText: comment.contents, commentId: comment.commentId)
//                    .presentationDetents([.medium])
                    .presentationDetents([.height(800)])
            }
            
        }
    }
}

struct CommentCell_Previews: PreviewProvider {
    static var previews: some View {
        CommentCell(comment: Comment(commentId: "123",
                                     commentTime: 0,
                                     contents: "goodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgood",
                                     perfumeScore: 4,
                                     writerId: "",
                                     writerNickName: "Ned",
                                     writerImage: "",
                                     likedPeople: []),
                    perfume: .constant(Perfume(perfumeId: "P394534",
                                     brandName: "Yves Saint Laurent",
                                     displayName: "Black Opium Eau de Parfum",
                                     heroImage: "https://www.sephora.com/productimages/sku/s1688852-main-grid.jpg",
                                     image450: "https://www.sephora.com/productimages/sku/s1688852-main-grid.jpg",
                                     fragranceFamily: "Floral",
                                     scentType: "Warm & Sweet Gourmands",
                                     keyNotes: ["Black Coffee", "White Flowers", "Vanilla"],
                                     fragranceDescription: "A women&rsquo;s fragrance that contains notes of coffee and vanilla.",
                                     likedPeople: ["1", "2"],
                                     commentCount: 154,
                                     totalPerfumeScore: 616)))
        .environmentObject(UserInfoStore())
    }
}
