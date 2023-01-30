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
    @State private var scentTypeCount: [String: Int] = [:]
    
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
                    }
                    .fullScreenCover(isPresented: $showEditMyProfileView) {
                        EditMyProfileView(image: $image, userNickname: $userNickname, userNation: $userNation)
                    }

                    Divider()
                    
                    ZStack {
                        ForEach(Array(PerfumeColor.types.enumerated()), id: \.offset) { index, color in
                            PalletteCell(color: color.color, degrees: Double(index) * 22.5, name: color.name, count: scentTypeCount[color.name] ?? 1)
                            
                            NameText(name: String(color.name.prefix(13)))
                                .foregroundColor(.white)
                                .font(.system(size: 12))
                                .rotationEffect(.radians((.pi * 2 / Double(PerfumeColor.types.count)) * Double(index)))
                                .zIndex(1)
                                .rotationEffect(.degrees(164))
                        }
                        .overlay(
                            Circle()
                                .fill(Color.white)
                                .frame(width: 100, height: 100)
                        )
                    }
                    .padding(.vertical, 170)
                    
                    NavigationLink{
                        WishListView()
                    }label: {
                        HStack{
                            Text("Wish List")
                                .fontWeight(.semibold)
                            Spacer()
                            Image(systemName: "chevron.right")

                        }
                        .padding(.bottom, 20)
                    }
                    .tint(.black)

                    HStack{
                        ForEach(0..<2){ _ in
                            WishListPerfumeCell(perfume: perfume)
                        }
                    }
                    //.frame(width: 300,)
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
                        userInfoStore.logOut()
                        dismiss()
                    } label: {
                        Text("Log Out")
                            .frame(width: 170, height: 50)
                            .background(Color.black)
                            .cornerRadius(7)
                            .foregroundColor(.white)

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
        .onAppear {
            //        forEach(dummy) { perfume in
            //            scentTypeCount[perfume.scentType] = (scentTypeCount[perfume.scentType] ?? 0) + 1
            //        }
            for perfume in dummy {
                scentTypeCount[perfume.scentType] = (scentTypeCount[perfume.scentType] ?? 0) + 1
            }
            
            print(scentTypeCount)
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
