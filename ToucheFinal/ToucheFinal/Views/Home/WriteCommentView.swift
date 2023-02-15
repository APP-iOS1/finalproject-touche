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
    @EnvironmentObject var userInfoStore: UserInfoStore
    @EnvironmentObject var commentStore: CommentStore
    @Environment(\.dismiss) var dismiss
    @StateObject var manager = TFManager()
    
    @State var oldScore: Int = 0
    @State var score: Int
    @Binding var isShowingWriteComment: Bool
    
    @Binding var perfume: Perfume
    var reviewText: String
    var commentId: String
    var placeholderString: String = "Comment"
    
    var body: some View {
        NavigationStack {
            ScrollView {
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
                // TextField
                ZStack {
                    TextEditor(text: $manager.reviewText)
                        .scrollContentBackground(.hidden)
                    // Placeholder
                    VStack {
                        HStack {
                            if manager.reviewText.isEmpty {
                                Text(placeholderString)
                                    .opacity(0.25)
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding([.leading, .top], 8)
                }
                .padding(5)
                .frame(width: 330, height: 130)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.gray, lineWidth: 0.5)
                )
                HStack {
                    Spacer()
                        Text("\(manager.reviewText.count)/200")
                            .foregroundColor(.gray)
                            .padding(.trailing, 13)
                }
                RatingView(score: $score, frame: 30, canClick: true)
                    .padding([.horizontal, .bottom])
                
                Button{
                    Task {
                        // TODO: - 함수 정리
                        guard let userInfo = userInfoStore.userInfo else {return}
                        await userInfoStore.fetchUser(user: userInfoStore.user)
                        if !commentId.isEmpty { // update comment
                            await commentStore.updateComment(perfumeId: perfume.perfumeId, commentId: commentId, contents: manager.reviewText, score: score)
                            await commentStore.fetchComments(perfumeId: perfume.perfumeId)
                            await perfumeStore.updateTotalPerfumeScore(perfumeId: perfume.perfumeId, oldScore: oldScore, newScore: score)
                            
                            
                        } else { // create comment
                            let comment = Comment(commentId: UUID().uuidString, commentTime: Date().timeIntervalSince1970, contents: manager.reviewText, perfumeScore: score , writerId: userInfo.userId, writerNickName: userInfo.userNickName, writerImage: userInfo.userProfileImage, likedPeople: [])
                            
                            await commentStore.setComment(comment: comment, perfumeId: perfume.perfumeId)
                            await commentStore.fetchComments(perfumeId: perfume.perfumeId)
                            await perfumeStore.updateCommentCount(perfumeId: perfume.perfumeId, score: score)
                            await userInfoStore.updateWrittenComment(perfumeId: perfume.perfumeId, commentId: comment.commentId)
                        }
                        perfume = await perfumeStore.fetchPerfume(perfumeId: perfume.perfumeId)
                        readPerfumes()
                        isShowingWriteComment = false
                    }
                }label: {
                    Text("Post Comment")
                        .frame(width: 330, height: 46)
                        .background(.black)
                        .foregroundColor(.white)
                        .cornerRadius(7)
                }
                .disabled(manager.reviewText.count < 1 || score < 1)
                Spacer()
            }
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
            .onAppear {
                manager.reviewText = reviewText
                oldScore = score
            }
        }
    }
    func readPerfumes() {
        if userInfoStore.user != nil {    //  로그인 상태일 때
            Task {
                await userInfoStore.fetchUser(user: userInfoStore.user)
                guard let recentlyPerfumesId = userInfoStore.userInfo?.recentlyPerfumesId else {return}
                if !recentlyPerfumesId.isEmpty {
                    await perfumeStore.readRecentlyPerfumes(perfumesId: recentlyPerfumesId)
                }
            }
        } else {    //  로그인 했을 경우
            Task {
                let recentlyPerfumesId = UserDefaults.standard.array(forKey: "recentlyPerfumesId") as? [String] ?? []
                if !recentlyPerfumesId.isEmpty {
                    await perfumeStore.readRecentlyPerfumes(perfumesId: recentlyPerfumesId)
                }
            }
        }
        
        Task {
            let selectedScentTypes = UserDefaults.standard.array(forKey: "selectedScentTypes") as? [String] ?? []
            await perfumeStore.readRecomendedPerfumes(perfumesId: setRecomendedPerfumesId(perfumesId: selectedScentTypes))
        }
    }
    func setRecomendedPerfumesId(perfumesId: [String]) -> [String] {
        return Array(perfumesId.prefix(10))
    }
}



// 150자 글자 수 제한
class TFManager: ObservableObject {
    @Published var reviewText = "comment" {
        didSet {
            if reviewText.count > 200 && oldValue.count <= 200 {
                reviewText = oldValue
            }
        }
    }
}

struct WriteCommentView_Previews: PreviewProvider {
    static var previews: some View {
        WriteCommentView(score: 4, isShowingWriteComment: .constant(true),
                         perfume: .constant(Perfume(perfumeId: "P258612",
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
                                         )), reviewText: "", commentId: "ddd")
    }
}
