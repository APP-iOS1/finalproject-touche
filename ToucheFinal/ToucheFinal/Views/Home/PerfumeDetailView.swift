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
    @State var test: Bool = false
    @State var isShowingWriteComment: Bool = false
    
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
                    HStack{
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
                                    RatingView(score: .constant(perfume.totalPerfumeScore / perfume.commentCount), frame: 15, canClick: false)
                                    Text("\("\(perfume.commentCount)개의 댓글 보기")")
                                        .font(.system(size: 14))
                                        .foregroundColor(.black)
                                        .underline()
                                }
                            }
                            .padding(.top, -10)
                        }
                        Spacer()
                        VStack(alignment: .leading){
                            VStack{
                                Button {
                                    test.toggle()
                                } label: {
                                    Image(systemName: test ? "heart.fill" : "heart")
                                        .resizable()
                                        .frame(width: 30, height: 27)
                                }
                                Text("\(perfume.likedPeople.count)")
                                    .padding(.top, -8)
                                    .foregroundColor(.black)
                                    .fontWeight(.light)
                            }
                            .foregroundColor(.red)
                        }
                        .padding(.trailing)
                    }
                    .frame(width: abs(geometry.size.width - 20), alignment: .leading)
                    .padding(.leading, 20)
                    Divider()
                        .padding(.bottom)
                    VStack(alignment: .leading, spacing: 5){
                        Text("FragranceFamily")
                            .bold()
                        Text(perfume.fragranceFamily)
                            .padding(.bottom)
                        Text("ScentType")
                            .bold()
                        Text(perfume.scentType)
                            .padding(.bottom)
                        Text("KeyNote")
                            .bold()
                        ForEach(perfume.keyNotes.indices, id: \.self) { index in    Text(perfume.keyNotes[index])
                        }
                        
                        Text("Descriptions")
                            .bold()
                            .padding(.top)
                        Text(perfume.fragranceDescription)
                            .padding(.bottom)
                        Group{
                            HStack{
                                Text("Comments")
                                    .font(.title2)
                                    .bold()
                                Spacer()
                                Button {
                                    isShowingWriteComment = true
                                } label: {
                                    Text("댓글 작성하기")
                                        .underline()
                                }.foregroundColor(.black)
                            }
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
                .fullScreenCover(isPresented: $isShowingWriteComment, content: {
                    WriteCommentView(perfume: perfume)
                })
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
                                               likedPeople: ["1", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3"],
                                               commentCount: 154,
                                               totalPerfumeScore: 616
                                              ))
        }
    }
}
