//
//  PerfumeDetailView.swift
//  ToucheFinal
//
//  Created by 조석진 on 2023/01/18.
//

import SwiftUI
import SDWebImageSwiftUI

struct PerfumeDetailView: View {
    /// dismiss action
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    /// firebase data
    @EnvironmentObject var perfumeStore: PerfumeStore
    @EnvironmentObject var userInfoStore: UserInfoStore
    /// moving to commentView
    @Namespace var reviewId
    /// toggling the heartState
    @State var heartState: Bool = false
    /// showing modal to write comment
    @State var isShowingWriteComment: Bool = false
    /// showing alert to whether login or not
    @State var alertActive = false
    /// trigger to move signinView
    @State var navLinkActive = false
    /// perfume data
    let perfume: Perfume
    
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
            If you want to use Liked / Comments,
            Please sign in
            """
            ,isPresented: $alertActive
        ) {
            Button("Cancel", role: .cancel) {}
            Button {
                navLinkActive = true
            } label: {
                Text("Sign In")
            }
        }
        .fullScreenCover(isPresented: $isShowingWriteComment){
            WriteCommentView(perfume: perfume, isShowingWriteComment: $isShowingWriteComment)
        }
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
    }
}

// MARK: HELPER FUNCTION
private extension PerfumeDetailView {
    /// 가상 키보드 해제 액션
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// MARK: VIEW EXTENSION
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
                
                Button {
                    withAnimation {
                        proxy.scrollTo(reviewId)
                    }
                } label: {
                    HStack{
                        RatingView(
                            score: .constant(perfume.commentCount == 0 ? perfume.totalPerfumeScore : perfume.totalPerfumeScore / perfume.commentCount),
                            frame: 15,
                            canClick: false)
                        Text("\("\(perfume.commentCount)개의 댓글 보기")")
                            .font(.system(size: 14))
                            .foregroundColor(.primary)
                            .underline()
// =======
//             ScrollViewReader { proxy in
//                 GeometryReader{ geometry in
//                     ScrollView {
//                         VStack{
//                             Rectangle()
//                                 .foregroundColor(.white)
//                                 .overlay {
//                                     WebImage(url: URL(string: perfume.heroImage))
//                                         .resizable()
//                                         .padding(100)
//                                 }
//                                 .frame(height: abs(geometry.size.width - 40))
//                                 .padding(.horizontal, 20)
//                                 .padding(.vertical, 40)
//                         }
//                         .background(Color("customGray"))
                        
//                         HStack{
//                             VStack(alignment: .leading){
//                                 Text(perfume.brandName)
//                                     .unredacted()
//                                 //                                .fontWeight(.semibold)
//                                     .foregroundColor(.black)
//                                 Text(perfume.displayName)
//                                     .font(.system(size: 14))
//                                     .foregroundColor(.black)
//                                 Button {
//                                     withAnimation {
//                                         proxy.scrollTo(reviewId)
//                                     }
//                                 } label: {
//                                     HStack{
//                                         RatingView(score: .constant(perfume.commentCount == 0 ? perfume.totalPerfumeScore : perfume.totalPerfumeScore / perfume.commentCount), frame: 15, canClick: false)
//                                         Text("\("\(perfume.commentCount)개의 댓글 보기")")
//                                             .font(.system(size: 14))
//                                             .foregroundColor(.black)
//                                             .underline()
//                                     }
//                                 }
//                                 .padding(.top, -10)
//                             }
                            
//                             Spacer()
                            
//                             VStack(alignment: .leading){
//                                 VStack{
//                                     if userInfoStore.user == nil {
//                                         Button {
//                                             heartState.toggle()
//                                         } label: {
//                                             Image(systemName: heartState ? "heart.fill" : "heart")
//                                                 .resizable()
//                                                 .frame(width: 30, height: 27)
//                                                 .foregroundColor(Color(hex: setHexValue(scentType: perfume.scentType)))
                                            
//                                         }
//                                         .alert(
//                                             """
//                                             If you want to use Liked / Comments,
//                                             Please sign in
//                                             """
//                                             ,isPresented: $heartState
//                                         ) {
//                                             Button("Cancel", role: .cancel) {}
//                                             Button {
//                                                 navLinkActive = true
//                                             } label: {
//                                                 Text("Sign In")
//                                             }
//                                         }
                                        
//                                     } else {
//                                         Button {
//                                             heartState.toggle()
//                                         } label: {
//                                             Image(systemName: heartState ? "heart.fill" : "heart")
//                                                 .resizable()
//                                                 .frame(width: 30, height: 27)
//                                                 .foregroundColor(Color(hex: setHexValue(scentType: perfume.scentType)))
                                            
//                                         }
//                                     }
                                    
//                                     //MARK: 네이게이션 링크로 signoutview로 이동(스택이 많이 쌓여서 보류)
// //                                    NavigationLink(isActive: $navLinkActive, destination: { SignOutView() }, label: {
// //                                        Text("")
// //                                    })
                                    
//                                     Text("\(perfume.likedPeople.count)")
//                                         .padding(.top, -8)
//                                         .foregroundColor(.black)
//                                         .fontWeight(.light)
//                                 }
//                             }
//                             .padding(.trailing)
//                             .modifier(SignInFullCover(isShowing: $navLinkActive))
//                         }
//                         .frame(width: abs(geometry.size.width - 20), alignment: .leading)
//                         .padding(.leading, 20)
//                         Divider()
//                             .padding(.bottom)
                        
//                         if userInfoStore.user == nil {
//                             VStack(alignment: .leading, spacing: 5){
//                                 Text("FragranceFamily")
//                                     .bold()
//                                 Text(perfume.fragranceFamily)
//                                     .padding(.bottom)
//                                 Text("ScentType")
//                                     .bold()
//                                 Text(perfume.scentType)
//                                     .padding(.bottom)
//                                 Text("KeyNote")
//                                     .bold()
//                                 ForEach(perfume.keyNotes.indices, id: \.self) { index in    Text(perfume.keyNotes[index])
//                                 }
                                
//                                 Text("Descriptions")
//                                     .bold()
//                                     .padding(.top)
//                                 Text(perfume.fragranceDescription)
//                                     .padding(.bottom)
//                                 Group{
//                                     HStack{
//                                         Text("Comments")
//                                             .font(.title2)
//                                             .bold()
//                                         Spacer()
//                                         Button {
//                                             alertActive = true
                                            
//                                             //MARK: alert없이 바로 로그인페이지로 이동시키기
//                                             //                                        if userInfoStore.user != nil {
//                                             //                                            isShowingWriteComment = true
//                                             //                                        } else {
//                                             //                                            navLinkActive = true
//                                             //                                        }
//                                         } label: {
//                                             Text("댓글 작성하기")
//                                                 .underline()
//                                         }.foregroundColor(.black)
//                                             .alert(
//                                                 """
//                                                 If you want to use Liked / Comments,
//                                                 Please sign in
//                                                 """
//                                                 ,isPresented: $alertActive
//                                             ) {
//                                                 Button("Cancel", role: .cancel) {}
//                                                 Button {
//                                                     navLinkActive = true
//                                                 } label: {
//                                                     Text("Sign In")
//                                                 }
//                                             }
//                                     }
//                                     ForEach(commentDummy, id: \.self.commentId) { comment in
//                                         Divider()
//                                         CommentCell(comment: comment)
//                                         //                                Divider()
//                                     }
//                                 }
//                             }
//                             .id(reviewId)
//                             .padding(.horizontal, 20)
//                             .padding(.bottom, 40)
//                             .modifier(SignInFullCover(isShowing: $navLinkActive))
                            
//                         } else {
//                             VStack(alignment: .leading, spacing: 5){
//                                 Text("FragranceFamily")
//                                     .bold()
//                                 Text(perfume.fragranceFamily)
//                                     .padding(.bottom)
//                                 Text("ScentType")
//                                     .bold()
//                                 Text(perfume.scentType)
//                                     .padding(.bottom)
//                                 Text("KeyNote")
//                                     .bold()
//                                 ForEach(perfume.keyNotes.indices, id: \.self) { index in    Text(perfume.keyNotes[index])
//                                 }
                                
//                                 Text("Descriptions")
//                                     .bold()
//                                     .padding(.top)
//                                 Text(perfume.fragranceDescription)
//                                     .padding(.bottom)
//                                 Group{
//                                     HStack{
//                                         Text("Comments")
//                                             .font(.title2)
//                                             .bold()
//                                         Spacer()
//                                         Button {
//                                             isShowingWriteComment = true
                                            
//                                             //MARK: alert없이 바로 로그인페이지로 이동시키기
//                                             //                                        if userInfoStore.user != nil {
//                                             //                                            isShowingWriteComment = true
//                                             //                                        } else {
//                                             //                                            navLinkActive = true
//                                             //                                        }
//                                         } label: {
//                                             Text("댓글 작성하기")
//                                                 .underline()
//                                         }.foregroundColor(.black)
//                                     }
//                                     ForEach(commentDummy, id: \.self.commentId) { comment in
//                                         Divider()
//                                         CommentCell(comment: comment)
//                                         //                                Divider()
//                                     }
//                                 }
//                             }
//                             .id(reviewId)
//                             .padding(.horizontal, 20)
//                             .padding(.bottom, 40)
//                         }
//                     }//ScrollView
//                     .navigationTitle(perfume.displayName)
//                     .navigationBarTitleDisplayMode(.inline)
//                     .fullScreenCover(isPresented: $isShowingWriteComment){
//                         WriteCommentView(perfume: perfume, isShowingWriteComment: $isShowingWriteComment)
// >>>>>>> origin/develop
                    }
                }
            } // VSTACK
            
            Spacer()
            
            // Like
            VStack(spacing: 16.0){
                Button {
                    heartState.toggle()
                } label: {
                    Image(systemName: heartState ? "heart.fill" : "heart")
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
            Text(perfume.scentType)
                .font(.body)
                .fontWeight(.light)
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
            
            Text("Comments")
                .font(.title2)
            + Text(" \(perfume.commentCount)")
                .font(.caption)
                .foregroundColor(.secondary)
        } // VSTACK
        .padding(.horizontal, 20)
        .modifier(SignInFullCover(isShowing: $navLinkActive))
    }
    
    /// Comment를 남길수 있는 뷰
    func commentView() -> some View {
        // MARK: - Comments
        ScrollView {
            Button {
                switch userInfoStore.userInfo {
                case nil:
                    alertActive = true
                default:
                    isShowingWriteComment = true
                }
            } label: {
                HStack(alignment: .center) {
                    Image("woman")
                        .resizable()
                        .frame(width: 50, height: 50)
                    
                    Text("Add Comment...")
                        .frame(height: 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.tertiary)
                        .padding(4.0)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8.0)
                                .strokeBorder(.tertiary, lineWidth: 1)
                        }
                    
                    Text("Send")
                        .frame(height: 50)
                }
            }
            .tint(.primary)
            
            ForEach(commentDummy, id: \.self.commentId) { comment in
                Divider()
                CommentCell(comment: comment)
            }
        }
        .onAppear{
            updateRecentlyPerfumes()
        }
        .onTapGesture {
            hideKeyboard()
        }
        .padding(.horizontal, 20)
        .autocapitalization(.none)
        .autocorrectionDisabled(true)
        .scrollDismissesKeyboard(.interactively)
    }
    func updateRecentlyPerfumes() {
        var recentlyPerfumesId: [String] = UserDefaults.standard.array(forKey: "recentlyPerfumesId") as? [String] ?? []
        if let perfumeIndex = recentlyPerfumesId.firstIndex(of: perfume.perfumeId) {
            recentlyPerfumesId.remove(at: perfumeIndex)
            recentlyPerfumesId.insert(perfume.perfumeId, at: 0)
        } else {
            if recentlyPerfumesId.count == 7 {
                recentlyPerfumesId.removeLast()
            }
            recentlyPerfumesId.insert(perfume.perfumeId, at: 0)
        }
        UserDefaults.standard.setValue(recentlyPerfumesId, forKey: "recentlyPerfumesId")
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
        }
    }
}


