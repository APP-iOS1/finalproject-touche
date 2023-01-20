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
    @State private var userNickname: String = "루나"
    @State private var showEditMyProfileView = false
    
    var body: some View {
        NavigationStack{
            VStack{
                Image(uiImage: self.image)
                    .resizable()
                    .cornerRadius(50)
                    .frame(width: 100, height: 100)
                    .background(Color.black.opacity(0.2))
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .padding(.bottom, 20)
                
                Text(userNickname)
                    .padding(.bottom,3)
                
                Button {
                    showEditMyProfileView.toggle()
                } label: {
                    Text("Edit Profile")
                }
                .fullScreenCover(isPresented: $showEditMyProfileView) {
                    EditMyProfileView(image: $image, userNickname: $userNickname)
                }
                
                Divider()
                HStack{
                    Text("Wish List")
                        .fontWeight(.semibold)
                    Spacer()
                    Image(systemName: "chevron.right")
                    
                    
                    
                }
                .padding(.bottom, 20)
                
                HStack{
                    Text("perfume1")
                    Text("perfume2")
                    Text("perfume3")
                }
                .padding(.bottom, 20)
                
                HStack{
                    Text("My Comment")
                        .fontWeight(.semibold)
                    Spacer()
                    // TODO:
                    NavigationLink {
                        // 리스트 형식으로 나의 코멘트 길게 보여주기
                        MyCommentListView()
                    } label: {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.black)
                    }

                }
                .padding(.bottom, 5)
                
                HStack{
                    VStack{
                        ForEach(0..<3) { _ in
                            MyPageMyCommentCell(perfume: dummy[0], comment: commentDummy[0])
                        }
                    }
                    .padding(.bottom, 20)
                    Spacer()
                }
                Button {
                    // 로그아웃 함수 들어갈 자리
                    UserDefaults.standard.set(false, forKey: "user")
                } label: {
                    Text("Log Out")
                        .frame(width: 170, height: 50)
                        .background(Color.black)
                        .cornerRadius(7)
                        .foregroundColor(.white)
                    
                }
            }
            .padding(14)
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

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView(perfume: dummy[0], comment: commentDummy[0])
    }
}
