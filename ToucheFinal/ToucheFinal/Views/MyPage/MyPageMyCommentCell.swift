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
        VStack{
            NavigationLink {
                PerfumeDetailView(perfume: perfume)
            } label: {
                HStack {
                    VStack {
                        WebImage(url: URL(string: perfume.heroImage))
                            .resizable()
                            .frame(width: 60, height: 60)
                        RatingView(score: .constant(perfume.totalPerfumeScore/perfume.commentCount), frame: 7, canClick: false)
                            .padding(.top, -5)
                            .padding(.leading, 10)
                    }
                    VStack(alignment: .leading) {
                        Text(perfume.brandName).font(.custom("NotoSans-Regular", size: 15))
                            .unredacted()
                          //  .padding(.bottom, 1)
//                            .fontWeight(.semibold)
                            .lineLimit(1)
                        Text(perfume.displayName).font(.custom("NotoSans-ExtraLight", size: 15))
                            .font(.system(size: 14))
                            .lineLimit(1)
                        Text(comment.contents).font(.custom("NotoSans-Regular", size: 10))
                            .lineLimit(1)
                            .padding(.bottom, 3)
                        
                    }
                }
                .foregroundColor(.black)
                .frame(width: 350, height: 100)
                .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(.white)
                    .shadow(color: .black.opacity(0.3), radius: 3.5))
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
                                    ), comment: Comment(commentId: "123", commentTime: 0, contents: "This just smells like mercedes benz intense, it's violet + jasmine and some citrus. Floral & citrusy, very similar to mercedes benz intens", perfumeScore: 4, writerId: "", writerNickName: "Ned", writerImage: "", likedPeople: []))
    }
}
