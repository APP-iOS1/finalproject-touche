//
//  PerfumeView.swift
//  ToucheFinal
//
//  Created by james seo on 2023/02/02.
//

import SwiftUI
import SDWebImageSwiftUI

struct PerfumeView: View {
    // init..
    let perfume: Perfume
    
    // MainView Properties
    @State private var show = true
    @Namespace private var animation
    @State private var hasScrolled = false
    
    // PerfumeCell Properties
    @State private var shouldAnimate = false
    
    // PerfumeDetailView Properties
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Namespace var reviewId
    @State var heartState: Bool = false
    @State var isShowingWriteComment: Bool = false
    @State var alertActive = false
    @State var navLinkActive = false
    @EnvironmentObject var userInfoStore: UserInfoStore
    
    var body: some View {
        ZStack {
            // MARK: - PerfumeCell
            if !show {
                VStack(alignment: .leading, spacing: 2.0) {
                    WebImage(url: URL(string: perfume.heroImage))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 130)
                        .matchedGeometryEffect(id: "image", in: animation)
                    
                    Text(perfume.brandName)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    
                    Text(perfume.displayName)
                        .font(.footnote)
                        .fontWeight(.light)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    
                    HStack(alignment: .center) {
                        Image(systemName: perfume.likedPeople.contains("userId") ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 13, height: 12)
                        Text("\(perfume.likedPeople.count)")
                            .font(.system(size: 14))
                        Image(systemName: "message")
                            .resizable()
                            .frame(width: 13, height: 13)
                        Text("\(perfume.commentCount)" )
                            .font(.system(size: 14))
                    }
                    .foregroundColor(.secondary)
                }
                .frame(width: 130)
                .padding(10.0)
                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .circular))
                .background(
                    RoundedRectangle(cornerRadius: 10.0, style: .circular)
                        .fill(Color.white)
                        .shadow(radius: 3, x: 1, y: 1)
                    )
                .overlay(alignment: .topTrailing, content: {
                    let color = Color(hex: setHexValue(scentType: perfume.scentType)) ?? .primary
                    Circle()
                        .fill(color.gradient)
                        .frame(width: 15, height: 15, alignment: .center)
                        .scaleEffect(shouldAnimate ? 1.2 : 1)
                        .padding([.top, .trailing], 8.0)
                        .shadow(
                            color: shouldAnimate ? color : color.opacity(0.1),
                            radius: shouldAnimate ? 3 : 1.5,
                            x: 0,
                            y: 0
                        )
                        .animation(.linear(duration: 2).delay(.random(in: 0.0..<1.0)).repeatForever(autoreverses: true), value: shouldAnimate)
                })
                .onAppear {
                    shouldAnimate = true
                }
                .onDisappear {
                    shouldAnimate = false
                }
                .onTapGesture {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        show.toggle()
                    }
                }
            } else {
                // MARK: - PerfumeDetailView
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
                                            .matchedGeometryEffect(id: "image", in: animation)
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
                                            RatingView(score: .constant(perfume.commentCount == 0 ? perfume.totalPerfumeScore : perfume.totalPerfumeScore / perfume.commentCount), frame: 15, canClick: false)
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
                                        if userInfoStore.user == nil {
                                            Button {
                                                heartState.toggle()
                                            } label: {
                                                Image(systemName: heartState ? "heart.fill" : "heart")
                                                    .resizable()
                                                    .frame(width: 30, height: 27)
                                                    .foregroundColor(Color(hex: setHexValue(scentType: perfume.scentType)))
                                                
                                            }
                                            .alert(
                                                """
                                                If you want to use Liked / Comments,
                                                Please sign in
                                                """
                                                ,isPresented: $heartState
                                            ) {
                                                Button("Cancel", role: .cancel) {}
                                                Button {
                                                    navLinkActive = true
                                                } label: {
                                                    Text("Sign In")
                                                }
                                            }
                                            
                                        } else {
                                            Button {
                                                heartState.toggle()
                                            } label: {
                                                Image(systemName: heartState ? "heart.fill" : "heart")
                                                    .resizable()
                                                    .frame(width: 30, height: 27)
                                                    .foregroundColor(Color(hex: setHexValue(scentType: perfume.scentType)))
                                                
                                            }
                                        }
                                        
                                        //MARK: 네이게이션 링크로 signoutview로 이동(스택이 많이 쌓여서 보류)
    //                                    NavigationLink(isActive: $navLinkActive, destination: { SignOutView() }, label: {
    //                                        Text("")
    //                                    })
                                        
                                        Text("\(perfume.likedPeople.count)")
                                            .padding(.top, -8)
                                            .foregroundColor(.black)
                                        //                                    .fontWeight(.light)
                                    }
                                }
                                .padding(.trailing)
                                .fullScreenCover(isPresented: $navLinkActive, content: {
                                    LogInSignUpView()
                                })
                            }
                            .frame(width: abs(geometry.size.width - 20), alignment: .leading)
                            .padding(.leading, 20)
                            Divider()
                                .padding(.bottom)
                            
                            if userInfoStore.user == nil {
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
                                                alertActive = true
                                                
                                                //MARK: alert없이 바로 로그인페이지로 이동시키기
                                                if userInfoStore.user != nil {
                                                    isShowingWriteComment = true
                                                } else {
                                                    navLinkActive = true
                                                }
                                            } label: {
                                                Text("댓글 작성하기")
                                                    .underline()
                                            }.foregroundColor(.black)
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
                                        }
                                        ForEach(commentDummy, id: \.self.commentId) { comment in
                                            Divider()
                                            CommentCell(comment: comment)
                                        }
                                    }
                                }
                                .id(reviewId)
                                .padding(.horizontal, 20)
                                .padding(.bottom, 40)
                                .fullScreenCover(isPresented: $navLinkActive, content: {
                                    LogInSignUpView()
                                })
                            } else {
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
                                                
                                                //MARK: alert없이 바로 로그인페이지로 이동시키기
//                                                if userInfoStore.user != nil {
//                                                    isShowingWriteComment = true
//                                                } else {
//                                                    navLinkActive = true
//                                                }
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
                        }//ScrollView
                        .navigationTitle(perfume.displayName)
                        .navigationBarTitleDisplayMode(.inline)
                        .fullScreenCover(isPresented: $isShowingWriteComment, content: {
                            WriteCommentView(perfume: perfume, isShowingWriteComment: $isShowingWriteComment)
                        })
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            self.mode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                        }
                        .foregroundColor(.black)
                    }
                }
                .navigationBarBackButtonHidden(true)
            }
        }
        
    }
}

struct PerfumeView_Previews: PreviewProvider {
    static let perfume = Perfume(perfumeId: "P258612",
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
    )
    static var previews: some View {
        PerfumeView(perfume: perfume)
            .environmentObject(UserInfoStore())
    }
}
