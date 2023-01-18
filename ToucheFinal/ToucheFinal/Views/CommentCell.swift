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
                RatingView(score: .constant(comment.perfumeScore))
            }
        }
    }
}

struct CommentCell_Previews: PreviewProvider {
    static var previews: some View {
        CommentCell(comment:     Comment(id: "123", commentTime: "", contents: "goodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgood", perfumeScore: 4, writerId: "", writerNickName: "Ned", writerImage: ""))
    }
}
