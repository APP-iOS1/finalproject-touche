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
        NavigationLink {
            PerfumeDetailView(perfume: perfume)
        } label: {
            HStack(alignment: .top, spacing: 12.0) {
                
                WebImage(url: URL(string: perfume.image450))
                    .resizable()
                    .frame(width: 80, height: 80)
                
                
                VStack(alignment: .leading, spacing: 4.0) {
                    Text(perfume.brandName).font(.custom("NotoSans-Regular", size: 15))
                        .unredacted()
                        .lineLimit(1)
                    Text(perfume.displayName).font(.custom("NotoSans-ExtraLight", size: 15))
                        .font(.system(size: 14))
                        .multilineTextAlignment(.leading)
                    Text(comment.contents).font(.custom("NotoSans-Regular", size: 10))
                        .multilineTextAlignment(.leading)
                        .lineLimit(1...2)
                    RatingView(score: .constant(perfume.totalPerfumeScore/perfume.commentCount), frame: 15, canClick: false)
                    
                    
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundColor(.primary)
        .frame(maxWidth: 400, alignment: .center)
        .padding(8.0)
        .overlay(alignment: .bottom) {
            Divider()
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
                                            ), comment: Comment(commentId: "123", commentTime: 0, contents: "This just smells like mercedes benz intense, it's violet + jasmine and some citrus. Floral & citrusy, very similar to mercedes benz intens", perfumeScore: 4, writerId: "", writerNickName: "Ned", writerImage: "", likedPeople: []))
    }
}
