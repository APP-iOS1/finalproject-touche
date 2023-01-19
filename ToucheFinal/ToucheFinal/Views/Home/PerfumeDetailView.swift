//
//  PerfumeDetailView.swift
//  ToucheFinal
//
//  Created by 조석진 on 2023/01/18.
//

import SwiftUI
import SDWebImageSwiftUI

struct PerfumeDetailView: View {
    @Namespace var reviewId
    var perfume: Perfume
    var body: some View {
        ScrollViewReader { proxy in
            GeometryReader{ geometry in
                ScrollView {
                    VStack{
                        Rectangle()
                            .foregroundColor(.white)
                            .overlay {
                                WebImage(url: URL(string: perfume.heroImage))
                                    .resizable()
                                    .padding(100)
                            }
                            .frame(height: abs(geometry.size.width - 40))
                            .padding(.horizontal, 20)
                            .padding(.vertical, 40)
                    }
                    .background(Color("customGray"))
                    
                    VStack(alignment: .leading){
                        Text(perfume.brandName)
                            .unredacted()
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        Text(perfume.displayName)
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                        Button {
                            withAnimation {
                                proxy.scrollTo(reviewId)
                            }
                        } label: {
                            HStack{
                                RatingView(score: .constant(perfume.totalPerfumeScore / perfume.commentCount))
                                Text("\("\(perfume.commentCount)개의 리뷰 보기")")
                                    .font(.system(size: 14))
                                    .foregroundColor(.black)
                                    .underline()
                            }
                        }
                        .padding(.top, -10)
                        
                    }
                                        .frame(width: abs(geometry.size.width - 20), alignment: .leading)
                    .padding(.leading, 20)
                    Divider()
                        .padding(.bottom)
                    VStack(alignment: .leading, spacing: 5){                       Text("FragranceFamily")
                            .bold()
                        Text(perfume.fragranceFamily)
                            .padding(.bottom)
                        Text("ScentType")
                            .bold()
                        Text(perfume.scentType)
                            .padding(.bottom)
                        Text("KeyNote")
                            .bold()
                        HStack{
                            ForEach(perfume.keyNotes.indices, id: \.self) { index in
                                if index < (perfume.keyNotes.count - 1) {    Text("\(perfume.keyNotes[index]),")
                                } else {
                                    Text(perfume.keyNotes[index])
                                }
                            }
                        }.padding(.bottom)
                        Text("Descriptions")
                            .bold()
                        Text(perfume.fragranceDescription)
                            .padding(.bottom)
                        Group{
                            Text("Comments")
                                .font(.title2)
                                .bold()
                            ForEach(commentDummy, id: \.self.commentId) { comment in
                                Divider()
                                CommentCell(comment: comment)
//                                Divider()
                            }
                        }
                    }
                    .id(reviewId)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
                .navigationTitle(perfume.displayName)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct PerfumeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            PerfumeDetailView(perfume: Perfume(perfumeId: "P258612",
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
                                              ))
        }
    }
}
