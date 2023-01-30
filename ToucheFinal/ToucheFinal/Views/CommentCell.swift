//
//  CommentCell.swift
//  ToucheFinal
//
//  Created by 조석진 on 2023/01/18.
//

import SwiftUI
import SDWebImageSwiftUI

struct CommentCell: View {
    var comment: Comment
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
                        
                    } label: {
                        Image(systemName: true ? "hand.thumbsup.fill" : "hand.thumbsup")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(.black)
                    }
                    Text("24")
                        .font(.system(size: 14))
                        .padding(.leading, -3)
                }
            }
        }
    }
}

struct CommentCell_Previews: PreviewProvider {
    static var previews: some View {
        CommentCell(comment: Comment(commentId: "123", commentTime: "", contents: "goodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgood", perfumeScore: 4, writerId: "", writerNickName: "Ned", writerImage: ""))
    }
}
