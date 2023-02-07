//
//  MyPageView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/17.
//

import SwiftUI
import FirebaseAuth
import SDWebImageSwiftUI

struct MyPageView: View {
    var perfume: Perfume
    var comment: Comment
    
    @State private var image: UIImage = UIImage()
    @State private var userNickname: String = ""
    @State private var showEditMyProfileView = false
    @State private var userNation: String = "🏳️"
    @State private var rotation: Double = 0
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userInfoStore: UserInfoStore
    @EnvironmentObject var commentStore: CommentStore
    @EnvironmentObject var perfumeStore: PerfumeStore
    
    @State private var selection: Selection = .comment

    let columns: [GridItem] = .init(repeating: .init(.flexible(), spacing: 4.0), count: 3)
    
    enum Selection {
        case comment
        case favorite
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16.0) {
                // PROFILE SECTION
                Group {
                    WebImage(url: URL(string: userInfoStore.userInfo?.userProfileImage ?? ""))
                        .resizable()
                        .cornerRadius(50)
                        .frame(width: 100, height: 100)
                        .background(Color.black.opacity(0.2))
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .padding(.top, 20)
                    
                    HStack{
                        Text(userInfoStore.userInfo?.userNickName ?? "")
//                        Text(userInfoStore.userInfo?.userNation.flag ?? "")
                    }
                    
                    
                    Button {
                        showEditMyProfileView.toggle()
                    } label: {
                        Text("Edit Profile")
                    }
                    .fullScreenCover(isPresented: $showEditMyProfileView) {
                        EditMyProfileView(image: $image, userNickname: $userNickname, userNation: $userNation)
                    }
                    
                } // GROUP
                
                
                // CONTENT SECTION
                HStack(alignment: .center, spacing: 20) {
                    Button {
                        selection = .comment
                    } label: {
                        Image(systemName: selection == .comment ? "pencil.circle.fill" : "pencil.circle")
                            .resizable()
                            .aspectRatio(1.0, contentMode: .fit)
                            .foregroundColor(selection == .comment ? .primary : .secondary)
                            .frame(height: 24.0)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    Button {
                        selection = .favorite
                    } label: {
                        Image(systemName: selection == .favorite ? "heart.fill" : "heart")
                            .resizable()
                            .aspectRatio(1.0, contentMode: .fit)
                            .foregroundColor(selection == .favorite ? .primary : .secondary)
                            .frame(height: 24.0)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                } // HSTACK : BUTTON GROUP
                .padding(.bottom, 1.0)
                
                
                switch selection {
                case .comment:
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack(alignment: .center, spacing: 12.0) {
                            ForEach(userInfoStore.writtenCommentsAndPerfumes, id: \.self.0) { (perfume, comment) in
                                MyPageMyCommentCell(perfume: perfume, comment: comment)
                            }
                        }
                        .padding(.vertical, 8.0)
                    } // SCROLL
                    .overlay(alignment: .top) {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(.quaternary)
                    }
                    .animation(.easeOut, value: selection)
                case .favorite:
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: columns, alignment: .center, spacing: 4.0) {
                            ForEach(perfumeStore.likedPerfumes, id: \.perfumeId) { (perfume: Perfume) in
                                NavigationLink {
                                    PerfumeDetailView(perfume: perfume)
                                } label: {
                                    WebImage(url: URL(string: perfume.image450))
                                        .resizable()
                                        .aspectRatio(1.0, contentMode: .fit)
                                        .clipShape(RoundedRectangle(cornerRadius: 4.0))
                                        .shadow(color: .primary.opacity(0.8) ,radius: 0.2)
                                        .overlay(alignment: .topTrailing) {
                                            Image(systemName: "arrowshape.turn.up.right")
                                                .padding(4.0)
                                                .tint(.primary)
                                        }
                                }

                            }
                        }
                        .padding(.vertical, 8.0)
                    } // SCROLL
                    .overlay(alignment: .top) {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(.quaternary)
                    }
                    .animation(.easeOut, value: selection)
                }
            } // VSTACK
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink {
                        SettingView()
                    } label: {
                        Image(systemName: "gearshape")
                            .foregroundColor(.black)
                    }
                }
            } // TOOLBAR
            .task {
                await userInfoStore.readWrittenComments()
                await perfumeStore.likedPerfumes(userId: userInfoStore.userInfo?.userId ?? "")
                
                await userInfoStore.fetchUser(user: userInfoStore.user)
                print(userInfoStore.writtenCommentsAndPerfumes)
                
                guard let user = Auth.auth().currentUser else {return}
                print("user? : \(user.uid)")
                userNickname = await userInfoStore.getNickName(uid: user.uid)
                await userInfoStore.fetchUser(user: user)
                print(userInfoStore.userInfo)
                await userInfoStore.readWrittenComments()
            }
        } // NAVIGATION
    }
}

struct NameText: View {
    let name: String
    var body: some View {
        HStack (spacing: 0){
            Text(name)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 35)
            Rectangle()
                .foregroundColor(Color.clear)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(height: 40)
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView(perfume: dummy[0], comment: commentDummy[0])
            .environmentObject(UserInfoStore())
    }
}
