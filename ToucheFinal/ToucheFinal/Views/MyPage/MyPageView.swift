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
    
    //  @State private var image: UIImage = UIImage()
    @State private var userNickname: String = ""
    @State private var showEditMyProfileView = false
    @State private var nation: String = ""
    @State private var rotation: Double = 0
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userInfoStore: UserInfoStore
    @EnvironmentObject var commentStore: CommentStore
    @EnvironmentObject var perfumeStore: PerfumeStore
    
    @State private var selection: Selection = .reviewed

    let columns: [GridItem] = .init(repeating: .init(.flexible(), spacing: 4.0), count: 3)
    
    enum Selection {
        case reviewed
        case liked
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16.0) {
                // PROFILE SECTION
                Group {
                    AnimatedImage(url: URL(string: userInfoStore.userInfo?.userProfileImage ?? ""))
                        .resizable()
                        .indicator(SDWebImageActivityIndicator.medium)
                        .transition(.fade)
                        .cornerRadius(50)
                        .frame(width: 100, height: 100)
                        .background {
                            Image(systemName: "person.fill")
                                .resizable()
                                .padding(.top, 6)
                                .padding(.horizontal, 3)
                                .foregroundColor(.gray)
                                .clipShape(Circle())
                                .overlay {
                                    Circle()
                                        .stroke(.gray, lineWidth: 0.1)
                                }
                        }
                        .aspectRatio(contentMode: .fill)
                        .padding(.bottom, 10)
                    
                    HStack{
                        Text(userInfoStore.userInfo?.userNickName ?? "")
                        //  Text(nation)
                        Text(userInfoStore.userInfo?.userNation.flag() ?? "")
                    }
                    
                    
                    Button {
                        showEditMyProfileView.toggle()
                    } label: {
                        Text("Edit Profile")
                    }
                    .fullScreenCover(isPresented: $showEditMyProfileView) {
                        //EditMyProfileView()
                        
                        /*
                        EditMyProfileView(image: $image, userNickname: $userNickname, userNation: $nation)
                         */
                        
                        //EditMyProfileView(userNickname: $userNickname, userNation: $nation)
                        
                        EditMyProfileView()
                    }
                    
                } // GROUP
                
                Divider()
                    //.padding(.bottom, 0)
                
                // CONTENT SECTION
                HStack(alignment: .center, spacing: 20) {
                    Button {
                        selection = .reviewed
                    } label: {
                        VStack {
                            Image(systemName: selection == .reviewed ? "pencil.circle.fill" : "pencil.circle")
                                .resizable()
                                .aspectRatio(1.0, contentMode: .fit)
                                .foregroundColor(selection == .reviewed ? .primary : .secondary)
                                .frame(height: 25.0)
                            
                            Text("Reviewed")
                                .foregroundColor(selection == .reviewed ? .primary : .secondary)
                                .font(.system(size: 15))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    Button {
                        selection = .liked
                    } label: {
                        VStack {
                            Image(systemName: selection == .liked ? "heart.fill" : "heart")
                                .resizable()
                                .aspectRatio(1.0, contentMode: .fit)
                                .foregroundColor(selection == .liked ? .primary : .secondary)
                                .frame(height: 25.0)
                            
                            Text("Liked")
                                .foregroundColor(selection == .liked ? .primary : .secondary)
                                .font(.system(size: 15))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                } // HSTACK : BUTTON GROUP
                .padding(.bottom, -10)
                
                switch selection {
                case .reviewed:
                    
                    if userInfoStore.writtenCommentsAndPerfumes.count == 0 {
                        Divider()
                        Spacer()
                        // TODO: 문구 수정하기
                        Text("Did not write a **review.**")
                            .multilineTextAlignment(.center)
                        Spacer()
                        Spacer()
                    } else {
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
                    }
                    
                    
                case .liked:
                    if perfumeStore.likedPerfumes.count == 0 {
                        Divider()
                        Spacer()
                        // TODO: 문구 수정하기
                        Text("You don't have **any perfume**\n that you **really like?**")
                            .multilineTextAlignment(.center)
                        Spacer()
                        Spacer()
                    } else {
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
                await perfumeStore.readLikedPerfumes(userId: userInfoStore.userInfo?.userId ?? "")
                
                await userInfoStore.fetchUser(user: userInfoStore.user)
                
                print(userInfoStore.writtenCommentsAndPerfumes)
                
                guard let user = Auth.auth().currentUser else {return}
                print("user? : \(user.uid)")
                
                userNickname = await userInfoStore.getNickName(uid: user.uid)
                
                await userInfoStore.fetchUser(user: user)
                //print(userInfoStore.userInfo)
                
                await userInfoStore.readWrittenComments()
                
                //nation = await userInfoStore.getProfileNationality(uid: user.uid)
            }
        } // NAVIGATION
        .refreshable {
            print("?")
        }
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
            .environmentObject(CommentStore())
            .environmentObject(PerfumeStore())
    }
}
