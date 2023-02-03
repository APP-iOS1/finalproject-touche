//
//  CommentCell.swift
//  ToucheFinal
//
//  Created by 조석진 on 2023/01/18.
//

import SwiftUI
import SDWebImageSwiftUI

struct CommentCell: View {
    @EnvironmentObject var userInfoStore: UserInfoStore
    @EnvironmentObject var commentStore: CommentStore
    @State var  comment: Comment
    let perfumeId: String
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
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(.gray, lineWidth: 0.1)
                    }
            }
            VStack(alignment: .leading){
                Text(comment.writerNickName)
                    .bold()
                Text(comment.contents)
                    .frame(width: 300, alignment: .leading)
                HStack {
                    RatingView(score: .constant(comment.perfumeScore), frame: 15, canClick: false)
                    Button {
                        Task {
                            guard let userId = userInfoStore.user?.uid else {return}
                            if comment.likedPeople.contains(userId) {
                            // 해당 uid 제거
                                await commentStore.deleteLikeComment(perfumeId: perfumeId, commentId: comment.commentId, userId: userId)
                            } else {
                                // 해당 uid 추가
                                await commentStore.addLikePerfume(perfumeId: perfumeId, commentId: comment.commentId, userId: userId)
                            }
                            comment = await commentStore.fetchComment(perfumeId: perfumeId, commentId: comment.commentId)
                        }
                        
                    } label: {
                        Image(systemName: comment.likedPeople.contains(userInfoStore.user?.uid ?? "") ? "hand.thumbsup.fill" : "hand.thumbsup")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(.black)
                    }
                    Text("\(comment.likedPeople.count)")
                        .font(.system(size: 14))
                        .padding(.leading, -3)
                }
            }
        }
    }
}

struct CommentCell_Previews: PreviewProvider {
    static var previews: some View {
        CommentCell(comment: Comment(commentId: "123", commentTime: 0, contents: "goodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgood", perfumeScore: 4, writerId: "", writerNickName: "Ned", writerImage: "", likedPeople: []), perfumeId: "")
    }
}
