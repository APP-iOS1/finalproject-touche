//
//  MyPageView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/17.
//

import SwiftUI

struct MyPageView: View {
    var perfume: Perfume
    var comment: Comment
    
    @State private var image = UIImage()
    @State private var userNickname: String = "LUNA"
    @State private var showEditMyProfileView = false
    @State private var userNation: String = "🏳️"
    @State private var rotation: Double = 0
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userInfoStore: UserInfoStore
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack{
                    Image(uiImage: self.image)
                        .resizable()
                        .cornerRadius(50)
                        .frame(width: 100, height: 100)
                        .background(Color.black.opacity(0.2))
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .padding(.bottom, 20)
                    HStack{
                        Text(userNickname)
                        Text(userNation)
                    }
                    .padding(.bottom,3)
                    Button {
                        showEditMyProfileView.toggle()
                    } label: {
                        Text("Edit Profile")
//                            .foregroundColor(Color.black)
                    }
                    .fullScreenCover(isPresented: $showEditMyProfileView) {
                        EditMyProfileView(image: $image, userNickname: $userNickname, userNation: $userNation)
                    }
                    .padding(.bottom, 15)

                    Divider()
                    VStack{
                        HStack{
                            // TODO:
                            NavigationLink {
                                // 리스트 형식으로 나의 코멘트 길게 보여주기
                                MyCommentListView()
                            } label: {
                                HStack {
                                    Text("My Comment").font(.custom("NotoSans-Regular", size: 19))
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
                                ForEach(0..<3) { _ in
                                    MyPageMyCommentCell(perfume: dummy[0], comment: commentDummy[0])
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
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.black)
                    }
                }
            }
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
