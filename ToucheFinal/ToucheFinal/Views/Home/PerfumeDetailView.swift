//
//  PerfumeDetailView.swift
//  ToucheFinal
//
//  Created by 조석진 on 2023/01/18.
//

import SwiftUI
import SDWebImageSwiftUI
import AlertToast

struct PerfumeDetailView: View {
    /// dismiss action
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    /// firebase data
    @EnvironmentObject var perfumeStore: PerfumeStore
    @EnvironmentObject var userInfoStore: UserInfoStore
    @EnvironmentObject var commentStore: CommentStore
    /// moving to commentView
    @Namespace var reviewId
    /// toggling the heartState
    @State var heartState: Bool = false
    /// showing modal to write comment
    @State var isShowingWriteComment: Bool = false
    /// showing alert to whether login or not
    @State var loginAlertActive = false
    @State var isCheckedReview = false
    /// trigger to move signinView
    @State var navLinkActive = false
    /// perfume data
    
    @State var perfume: Perfume
    @State var totalScore: Int = 0
    var viewSize: Double {
        UIScreen.main.bounds.width
        
    }

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                //  MARK: - Main Image
                WebImage(url: URL(string: perfume.image450))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
                    .padding(.vertical, 20)
                
                VStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color("customGray"))
                        .frame(height:20)
                    
                    // intro
                    introView(proxy)
                    
                    Divider()
                    
                    // description
                    descriptionView()
                    
                    // comment
                    commentView()
                        .id(reviewId)
                    
                } // VSTACK
            } // SCROLL
        } // READER
        .alert(
            """
            Sign in to favorite your products
            """
            ,isPresented: $loginAlertActive
        ) {
            Button("Cancel", role: .cancel) {}
            Button {
                navLinkActive = true
            } label: {
                Text("Sign In")
            }
        }
        .alert(
            """
            You already wrote a review with the same account.
            """
            ,isPresented: $isCheckedReview
        ) {
            Button("OK", role: .cancel) {}
        }

        .sheet(isPresented: $isShowingWriteComment, content: {
            WriteCommentView(score: 0, isShowingWriteComment: $isShowingWriteComment, perfume: $perfume, reviewText: "", commentId: "")
//                .presentationDetents([.medium])
                .presentationDetents([.height(viewSize > 375 ? 450 : 450)])
        })
        .modifier(SignInFullCover(isShowing: $navLinkActive))
        .navigationTitle(perfume.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    self.mode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
                .foregroundColor(.primary)
            }
        }
        .onAppear{
        print(viewSize)
            updateRecentlyPerfumes()
            Task{
                await commentStore.fetchComments(perfumeId: perfume.perfumeId)
            }
            print(perfume.perfumeId)
        }
        .onDisappear {
            Task {
                if userInfoStore.user != nil {    //  로그인
                    await userInfoStore.fetchUser(user: userInfoStore.user)
                    guard let recentlyPerfumesId = userInfoStore.userInfo?.recentlyPerfumesId else {return}
                    if !recentlyPerfumesId.isEmpty {
                        await perfumeStore.readRecentlyPerfumes(perfumesId: recentlyPerfumesId)
                    }
                } else {    //  비로그인
                    let recentlyPerfumesId = UserDefaults.standard.array(forKey: "recentlyPerfumesId") as? [String] ?? []
                    if !recentlyPerfumesId.isEmpty {
                        await perfumeStore.readRecentlyPerfumes(perfumesId: recentlyPerfumesId)
                    }
                }
                let selectedScentTypes = UserDefaults.standard.array(forKey: "selectedScentTypes") as? [String] ?? []
                let perfumesId = setRecomendedPerfumesId(perfumesId: selectedScentTypes)
                await perfumeStore.readRecomendedPerfumes(perfumesId: perfumesId)
                await perfumeStore.readMostCommentsPerfumes()
            }
        }
    }
    
    func setRecomendedPerfumesId(perfumesId: [String]) -> [String] {
        return Array(perfumesId.prefix(10))
    }
}

// MARK: - VIEW EXTENSION
private extension PerfumeDetailView {
    /// 향수 브랜드, 제품, 순위 뷰
    func introView(_ proxy: ScrollViewProxy) -> some View {
        HStack{
            // brand
            VStack(alignment: .leading, spacing: 4.0){
                Text(perfume.brandName)
                    .foregroundColor(.primary)
                    .font(.headline)
                
                Text(perfume.displayName)
                    .foregroundColor(.primary)
                    .font(.subheadline)
                    .fontWeight(.light)
                
                HStack {
                    RatingView(
                        score: .constant(perfume.commentCount == 0 ? perfume.totalPerfumeScore : perfume.totalPerfumeScore / perfume.commentCount),
                        frame: 15,
                        canClick: false)
                    Button {
                        withAnimation {
                            proxy.scrollTo(reviewId)
                        }
                    } label: {
                        HStack{
                            Text("\("\(perfume.commentCount) View Comments")")
                                .font(.system(size: 14))
                                .foregroundColor(.primary)
                                .underline()
                        }
                    }
                }
            } // VSTACK
            
            Spacer()
            
            // Like
            VStack(spacing: 16.0){
                Button {
                    switch userInfoStore.user?.isEmailVerified ?? false {
                    case false:
                        loginAlertActive = true
                    default:
                        Task {
                            if perfume.likedPeople.contains(userInfoStore.currentUser ?? "") {
                                // 해당 uid 제거
                                await perfumeStore.deleteLikePerfume(perfume: perfume, userId: userInfoStore.currentUser ?? "")
                                
                            } else {
                                // 해당 uid 추가
                                await perfumeStore.addLikePerfume(perfume: perfume, userId: userInfoStore.currentUser ?? "")
                                
                            }
                            perfume = await perfumeStore.fetchPerfume(perfumeId: perfume.perfumeId)
                            heartState.toggle()
                        }
                    }
                } label: {
                    // likedPeople에 uid 여부
                    Image(systemName: perfume.likedPeople.contains(userInfoStore.currentUser ?? "") ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color(hex: setHexValue(scentType: perfume.scentType)))
                }
                
                Text("\(perfume.likedPeople.count)")
                    .padding(.top, -8)
                    .foregroundColor(.black)
                    .fontWeight(.light)
                
            } // VSTACK
            
        } // HSTACK
        .padding(.horizontal, 20)
    }
    
    // MARK: - Methods
    
    /// 향수 설명 뷰
    func descriptionView() -> some View {
        // MARK: - Description
        VStack(alignment: .leading, spacing: 4) {
            Text("FragranceFamily")
                .font(.body)
                .fontWeight(.semibold)
            
            Text(perfume.fragranceFamily)
                .font(.body)
                .fontWeight(.light)
                .padding(.bottom)
            
            Text("ScentType")
                .font(.body)
                .fontWeight(.semibold)
            
            HStack {
                Rectangle()
                    .fill(Color(hex: setHexValue(scentType: perfume.scentType)) ?? Color.white)
                    .frame(width: 6, height: 18)
                
                Text(perfume.scentType)
                    .font(.body)
                    .fontWeight(.light)
            }
            .padding(.bottom)
            
            Text("KeyNote")
                .font(.body)
                .fontWeight(.semibold)
            
            ForEach(perfume.keyNotes, id: \.self) { note in
                Text(note)
                    .font(.body)
                    .fontWeight(.light)
            }
            
            Text("Descriptions")
                .font(.body)
                .fontWeight(.semibold)
                .padding(.top)
            
            Text(perfume.fragranceDescription)
                .font(.body)
                .fontWeight(.light)
                .padding(.bottom)
            HStack {
                Text("Comments")
                    .font(.title2)
                + Text(" \(perfume.commentCount)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                Text("Leave your review")
                    .underline()
                    .onTapGesture(perform: {
                        switch userInfoStore.user?.isEmailVerified ?? false {
                        case false:
                            loginAlertActive = true
                            
                        default:
                            // 이미 리뷰를 작성한 적이 있는지
                            if commentStore.comments.filter({ $0.writerId == userInfoStore.currentUser }).count == 0 {
                                isShowingWriteComment = true
                            } else {
                                isCheckedReview = true
                            }
                            
                        }
                    })
            }
            .padding(.top, 10)
        } // VSTACK
        .padding(.horizontal, 20)
        .modifier(SignInFullCover(isShowing: $navLinkActive))
    }
    
    
    /// Comment를 남길수 있는 뷰
    func commentView() -> some View {
        // MARK: - Comments
        ScrollView {
            // Comments
            ForEach(commentStore.comments, id: \.self) { comment in
                Divider()
                CommentCell(comment: comment, perfume: $perfume)
            }
        }//
        .onTapGesture {
            hideKeyboard()
        }
        .padding([.horizontal, .bottom], 20)
        .autocapitalization(.none)
        .autocorrectionDisabled(true)
        .scrollDismissesKeyboard(.interactively)
    }
    
    func updateRecentlyPerfumes() {
        if userInfoStore.user?.uid != nil {
            Task {
                var recentlyPerfumesId: [String] =  userInfoStore.userInfo?.recentlyPerfumesId ?? []
                recentlyPerfumesId = setPerfumesId(perfumesId: recentlyPerfumesId)
                await userInfoStore.updateRecentlyPerfumes(recentlyPerfumesId: recentlyPerfumesId)
                await userInfoStore.fetchUser(user: userInfoStore.user)
            }
        } else {
            var recentlyPerfumesId: [String] = UserDefaults.standard.array(forKey: "recentlyPerfumesId") as? [String] ?? []
            recentlyPerfumesId = setPerfumesId(perfumesId: recentlyPerfumesId)
            UserDefaults.standard.setValue(recentlyPerfumesId, forKey: "recentlyPerfumesId")
        }
    }
    
    func setPerfumesId(perfumesId: [String]) -> [String] {
        var recentlyPerfumesId = perfumesId
        if let perfumeIndex = recentlyPerfumesId.firstIndex(of: perfume.perfumeId) {
            recentlyPerfumesId.remove(at: perfumeIndex)
            recentlyPerfumesId.insert(perfume.perfumeId, at: 0)
        } else {
            if recentlyPerfumesId.count == 7 {
                recentlyPerfumesId.removeLast()
            }
            recentlyPerfumesId.insert(perfume.perfumeId, at: 0)
        }
        return recentlyPerfumesId
    }
    
}

struct PerfumeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PerfumeDetailView(perfume: Perfume(perfumeId: "P258612",
                                               brandName: "CHANEL",
                                               displayName: "CHANCE EAU TENDRE Eau de Toilette",
                                               heroImage: "https://www.sephora.com/productimages/sku/s2238145-main-grid.jpg",
                                               image450: "https://www.sephora.com/productimages/sku/s2238145-main-grid.jpg",
                                               fragranceFamily: "Fresh",
                                               scentType: "Earthy Greens & Herbs",
                                               keyNotes: ["Citron", "Jasmine", "Teakwood"],
                                               fragranceDescription: "The delicate and unexpected fruity-floral fragrance for women creates a soft whirlwind of happiness, fantasy, and radiance.",
                                               likedPeople: ["1", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3"],
                                               commentCount: 154,
                                               totalPerfumeScore: 616
                                              ))
            .environmentObject(UserInfoStore())
            .environmentObject(PerfumeStore())
            .environmentObject(CommentStore())
        }
    }
}

// MARK: - HELPER FUNCTION
extension PerfumeDetailView {
    /// 가상 키보드 해제 액션
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

