//
//  MyPageView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/17.
//

import SwiftUI

struct MyPageView: View {
    
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
                    Image(systemName: "chevron.right")
                }
                .padding(.bottom, 20)
                
                VStack{
                    Text("My Comment1")
                    Text("My Comment2")
                    Text("My Comment3")
                }
                .padding(.bottom, 20)
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
        MyPageView()
    }
}
