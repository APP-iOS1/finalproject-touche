//
//  WriteCommentView.swift
//  ToucheFinal
//
//  Created by MIJU on 2023/01/18.
//

import SwiftUI

struct WriteCommentView: View {
//    @State private var reviewText: String = ""
    @EnvironmentObject var perfumeStore: PerfumeStore
    @EnvironmentObject var userInfoSore: UserInfoStore
    @EnvironmentObject var commentStore: CommentStore
    @Environment(\.dismiss) var dismiss
    
    @StateObject var manager = TFManager()
    @State private var score: Int = 0
    
    @Binding var isShowingWriteComment: Bool
    
    var perfume: Perfume
    var placeholderString: String = "Review"
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                HStack {
                    AsyncImage(url: URL(string: perfume.heroImage)) { image in
                        image
                            .resizable()
                            .frame(width:90, height: 90)
                    } placeholder: {
                        ProgressView()
                    }
                    VStack(alignment: .leading) {
                        Spacer()
                        Text(perfume.displayName)
                        Spacer()
                        Text(perfume.brandName)
                            .foregroundColor(.gray)
                        Spacer()
                        
                        HStack {
                            Image(systemName: "person")
                            Text("(\(perfume.commentCount))")
                            RatingView(score: .constant(perfume.commentCount == 0 ? perfume.totalPerfumeScore : perfume.totalPerfumeScore / perfume.commentCount), frame: 15, canClick: false)
                        }
                        Spacer()
                    }
                    .frame(height: 90)
                    Spacer()
                }
                
                VStack {
//                    TextField("Review", text: $manager.reviewText, axis: .vertical)
                    //                        .padding(5)
                    TextEditor(text: $manager.reviewText)
                        .scrollContentBackground(.hidden)
                        .foregroundColor(manager.reviewText == placeholderString ? .gray : .primary)
                        .onTapGesture {
                            if manager.reviewText == placeholderString {
                                manager.reviewText = ""
                            }
                        }
                    Spacer()
                }
                .padding(5)
                .frame(width: 330, height: 130)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.gray, lineWidth: 0.5)
                )
                HStack {
                    Spacer()
                    if manager.reviewText == "Review" {
                        Text("\(0)/200")
                            .foregroundColor(.gray)
                            .padding(.trailing, 13)
                    } else {
                        Text("\(manager.reviewText.count)/200")
                            .foregroundColor(.gray)
                            .padding(.trailing, 13)
                    }
                }
                
                RatingView(score: $score, frame: 30, canClick: true)
                    .padding([.horizontal, .bottom])
                
                Button{
                    Task {
                        guard let userInfo = userInfoSore.userInfo else {return}
                        let comment = Comment(commentId: UUID().uuidString, commentTime: Date().timeIntervalSince1970, contents: manager.reviewText, perfumeScore: score , writerId: userInfo.userId, writerNickName: userInfo.userNickName, writerImage: userInfo.userEmail, likedPeople: [])
                        
                        await commentStore.setComment(comment: comment, perfumeId: perfume.perfumeId)
                        await commentStore.fetchComments(perfumeId: perfume.perfumeId)
                        await perfumeStore.updateCommentCount(perfumeId: perfume.perfumeId, score: score)
                        isShowingWriteComment.toggle()
                    }
                }label: {
                    Text("Post Review")
                        .frame(width: 330, height: 46)
                        .background(.black)
                        .foregroundColor(.white)
                        .cornerRadius(7)
                }
                .disabled(manager.reviewText.count < 1 || score < 1)
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isShowingWriteComment.toggle()
                    } label: {
                        //                        Text("Cancel")
                        Image(systemName: "xmark")
                            .foregroundColor(Color.black)
                    }
                }
            }
        }
    }
}



// 150자 글자 수 제한
class TFManager: ObservableObject {
    @Published var reviewText = "Review" {
        didSet {
            if reviewText.count > 200 && oldValue.count <= 200 {
                reviewText = oldValue
            }
        }
    }
}

struct WriteCommentView_Previews: PreviewProvider {
    static var previews: some View {
        WriteCommentView(isShowingWriteComment: .constant(true),
                         perfume: Perfume(perfumeId: "P258612",
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
