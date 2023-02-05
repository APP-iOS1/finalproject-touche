//
//  MyPageView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/17.
//

import SwiftUI
import FirebaseAuth

struct MyPageView: View {
    var perfume: Perfume
    var comment: Comment
    
    @State private var image = UIImage()
    @State private var userNickname: String = ""
    @State private var showEditMyProfileView = false
    @State private var userNation: String = "🏳️"
    @State private var rotation: Double = 0
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userInfoStore: UserInfoStore
    @EnvironmentObject var commentStore: CommentStore
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack{
                    HStack {
                        Image(uiImage: self.image)
                            .resizable()
                            .cornerRadius(50)
                            .frame(width: 100, height: 100)
                            .background(Color.black.opacity(0.2))
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                        VStack{
                            HStack{
                                Text("Location :")
                                Text(userNation)
                            }
                            .padding(.bottom,1)
                            HStack{
                                Text("Name :")
                                Text("\(userNickname)")
                            }
                            .padding(.bottom,9)
                            Button {
                                showEditMyProfileView.toggle()
                            } label: {
                                Text("Edit Profile")
                                //                            .foregroundColor(Color.black)
                            }
                            .fullScreenCover(isPresented: $showEditMyProfileView) {
                                EditMyProfileView(image: $image, userNickname: $userNickname, userNation: $userNation)
                            }
                        }
                        .padding(.leading)
                    }
                    .padding(.bottom,20)
                    
                    Group {
                        //                    마이 프로필 세로 형태
                        //                    Image(uiImage: self.image)
                        //                        .resizable()
                        //                        .cornerRadius(50)
                        //                        .frame(width: 100, height: 100)
                        //                        .background(Color.black.opacity(0.2))
                        //                        .aspectRatio(contentMode: .fill)
                        //                        .clipShape(Circle())
                        //                        .padding(.bottom, 20)
                        //                    HStack{
                        //                        Text(userNickname)
                        //                        Text(userNation)
                        //                    }
                        //                    .padding(.bottom,1)
                        //                    Button {
                        //                        showEditMyProfileView.toggle()
                        //                    } label: {
                        //                        Text("Edit Profile")
                        ////                            .foregroundColor(Color.black)
                        //                    }
                        //                    .fullScreenCover(isPresented: $showEditMyProfileView) {
                        //                        EditMyProfileView(image: $image, userNickname: $userNickname, userNation: $userNation)
                        //                    }
                        //                    .padding(.bottom, 15)
                    } //세로 묶음 주석
                    Divider()
                    VStack{
                        HStack{
                            // TODO:
                            NavigationLink {
                                // 리스트 형식으로 나의 코멘트 길게 보여주기
                                MyCommentListView()
                            } label: {
                                HStack {
                                    Text("My Comment")
                                    //.fontWeight(.semibold)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        
                                }
//                                .offset(x: -8)
                                .foregroundColor(.black)
                            }
                            
                        }
                        .padding(.top, 15)
                        .padding(.bottom, 15)
                        
                            VStack(alignment: .center){
                                ForEach(userInfoStore.writtenCommentsAndPerfumes, id: \.self.0) { (perfume, comment) in
                                    MyPageMyCommentCell(perfume: perfume, comment: comment)
                                        .padding(.bottom, 20)
                                }
                            }
                            .padding(.bottom, 20)
                            Spacer()
                        
                    }
                }
                .padding(14)
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink {
                        SettingView()
                    } label: {
                        Image(systemName: "gearshape")
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .task {
            userNickname = await userInfoStore.getNickName(uid: Auth.auth().currentUser?.uid ?? "")
            await userInfoStore.fetchUser(user: userInfoStore.user)
            await userInfoStore.readWrittenComments()
            print(userInfoStore.writtenCommentsAndPerfumes)
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
    }
}
