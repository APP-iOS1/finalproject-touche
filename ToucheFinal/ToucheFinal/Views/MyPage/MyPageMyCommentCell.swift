//
//  MyPageMyCommentCell.swift
//  ToucheFinal
//
//  Created by 이재희 on 2023/01/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct MyPageMyCommentCell: View {
    var perfume: Perfume
    var comment: Comment
    
    var body: some View {
        NavigationStack{
            NavigationLink {
                PerfumeDetailView(perfume: perfume)
            } label: {
                HStack(alignment: .top) {
                    WebImage(url: URL(string: perfume.heroImage))
                        .resizable()
                        .frame(width: 80, height: 80)
                    VStack(alignment: .leading) {
                        Text(perfume.brandName)
                            .unredacted()
                            .fontWeight(.semibold)
                            .lineLimit(1)
                        Text(perfume.displayName)
                            .font(.system(size: 14))
                            .lineLimit(1)
                        Text(comment.contents)
                            .lineLimit(1)
                        RatingView(score: .constant(perfume.totalPerfumeScore/perfume.commentCount), frame: 15, canClick: false)
                            .padding(.top, -10)
                    }
                }
                .foregroundColor(.black)
            }
        }
    }
}

struct MyPageMyCommentCell_Previews: PreviewProvider {
    static var previews: some View {
        MyPageMyCommentCell(perfume: Perfume(perfumeId: "P258612",
                                     brandName: "CHANEL",
                                     displayName: "CHANCE EAU TENDRE Eau de Toilette",
                                     heroImage: "https://www.sephora.com/productimages/sku/s2238145-main-grid.jpg",
                                     image450: "https://www.sephora.com/productimages/sku/s2238145-main-grid.jpg",
                                     fragranceFamily: "Fresh",
                                     scentType: "Fresh Fruity Florals",
                                     keyNotes: ["Citron", "Jasmine", "Teakwood"],
                                     fragranceDescription: "The delicate and unexpected fruity-floral fragrance for women creates a soft whirlwind of happiness, fantasy, and radiance.",
                                     likedPeople: ["1", "2"],
                                     commentCount: 154,
                                     totalPerfumeScore: 616
                                    ), comment: Comment(commentId: "123", commentTime: "", contents: "goodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgood", perfumeScore: 4, writerId: "", writerNickName: "Ned", writerImage: ""))
    }
}
