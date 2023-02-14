//
//  EditMyProfileView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/18.
//

import SwiftUI
import FirebaseAuth
import SDWebImageSwiftUI

struct EditMyProfileView: View {
    @State private var isShowingDialog: Bool = false
    @State private var dialogTitle: String = "Title"
    // 뷰에 반영된건 없는데, confirmationDialog 에서 안쓰면 에러나서 씀
    @State private var showGallerySheet = false
    @State private var showCameraSheet = false
    @State private var editName: String = ""
    @State private var editIsValid: Bool =  false
    /// nickName 중복처리 true/false 확인용
    @State private var nickNameCheck: Bool = false
    @State private var editImage: UIImage = UIImage()
    @State private var editNation: String = ""
    /// photo picker로 갤러리에서 이미지 변경시 사용
    @State private var isChangedImage: Bool = false
    
    @State private var isSelected: [Bool] = [false, false, false, false, false]
    
    @Binding var image: UIImage
    @Binding var userNickname: String
    @Binding var userNation: String
   
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userInfoStore: UserInfoStore
    var nation: [String] = ["🇺🇸", "🇰🇷", "🇫🇷", "🇪🇸", "🇨🇦"]
    
    var body: some View {
        NavigationView {
            VStack{
                ZStack {
                    WebImage(url: URL(string: userInfoStore.userInfo?.userProfileImage ?? ""))
                        .resizable()
                        .cornerRadius(50)
                        .frame(width: 100, height: 100)
                        .background(Color.black.opacity(0.2))
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .padding(.bottom, 20)
                    
                    if isChangedImage == true {
                        Image(uiImage: self.editImage)
                            .resizable()
                            .cornerRadius(50)
                            .frame(width: 100, height: 100)
                            .background(Color.black.opacity(0.2))
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .padding(.bottom, 20)
                    }
                }
                
                Button("Edit Photo"){
                    isShowingDialog = true
                    isChangedImage = true
                }
                .confirmationDialog(dialogTitle, isPresented: $isShowingDialog){
                    Button("Change from Gallery"){
                        showGallerySheet = true
                    }
                    
                    Button("Take Photo"){
                        showCameraSheet = true
                    }
                    
                    Button("Cancel",role: .cancel){
                        isShowingDialog = false
                    }
                }
                .padding(.bottom, 15)
                
                Divider()
                    .frame(maxWidth: .infinity)
                
                VStack{
                    HStack{
                        Text("Nickname")
                        Spacer(minLength: 50)
                        
                        VStack{
                            TextField("Edit your Name", text: $editName)
                                .padding(.bottom, -5)
                                .foregroundColor(.black)
                                .keyboardType(.alphabet)
                                .modifier(KeyboardTextField())
                            // 닉네임 변경시, 닉네임 개수 0이상 20미만, 닉네임중복 아닐경우 true.
                                .onChange(of: editName) { value in
                                    if editName.count > 0 && editName.count < 20 {
                                        self.editIsValid = true
                                    } else {
                                        self.editIsValid = false
                                    }
                                }
                            Rectangle().frame(height: 0.45)
                                .foregroundColor(Color(uiColor: .systemGray5))
                        }
                    } // 네임 텍스트 필드 HStack
                    //  .padding(.bottom, 25)
                    .padding(.bottom, 10)
                  
                    HStack{
                        Text("Email")
                        Spacer(minLength: 50)   //  추가
                        
                        VStack(alignment: .leading){
                            Text(userInfoStore.userInfo?.userEmail ?? "")
                                .padding(.bottom, -5)
                        
                            Rectangle()//   .frame(height: 0.66)
                                .frame(height: 0.45)
                                .foregroundColor(Color(uiColor: .systemGray5))
                        }
                        //  .frame(width: 276)
                        .frame(width: 235)
                    } // 이메일 HStack
                    .padding(.bottom, 10)
                    
                    HStack {
                        Text("Region")
                        Spacer(minLength: 60)
                        VStack{
                            HStack {
                                ForEach(0 ..< 5) { idx in
                                    Button {
                                        
                                        //  모든 애들을
                                        for idx in isSelected.indices {
                                            
                                            isSelected[idx] = false //  여기서 다 끔
                                        }
                                        
                                        isSelected[idx].toggle()    //  해당 idx만 on!
                                        userNation = nation[idx]
                                    } label: {
                                        Text(nation[idx])
                                            .overlay(
                                                Circle().stroke(isSelected[idx] ? .green : .clear, lineWidth: 2)
                                            )
                                    }
                                    .buttonStyle(.customButton)
                                    .padding(.trailing, -13)
                                }
                                
                                Spacer()
                            }
                        }
                    } // 로케이션 HStack
                 
                    }
                    //.border(.black)
                    .padding()
                
                    Divider()
                        //.frame(minWidth: .infinity)
                    Spacer()
                }
            .sheet(isPresented: $showGallerySheet){
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$editImage)}
            .sheet(isPresented: $showCameraSheet) {
                ImagePicker(sourceType: .camera, selectedImage: self.$editImage)
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done"){
                        Task {
                            // TODO: 닉네임 수정시 중복확인하는 부분
                            /*
                            do {
                                let target = try await userInfoStore.isNicknameDuplicated(nickName: editName)
                                nickNameCheck = target
                            } catch {
                                throw(error)
                            }
                             */
                            
                            //if editIsValid && nickNameCheck == false {
                                // 수정 완료 기능
//                                userNickname = editName
//                                userNation = editNation
                                
                                await userInfoStore.updateUserNickName(uid: Auth.auth().currentUser?.uid ?? "", nickname: editName)
//                            }
                            
                            let strImg = await userInfoStore.uploadPhoto([editImage.pngData() ?? Data()])
                            
                            await userInfoStore.setProfilePhotoUrl(uid: userInfoStore.user?.uid ?? "", userProfileImageUrl: strImg.last ?? "")
                            
                            await userInfoStore.setProfileNationality(uid: userInfoStore.user?.uid ?? "", nation: userNation)
                            
                            await userInfoStore.fetchUser(user: userInfoStore.user)
                            
                            dismiss()
                        }
                    }
                    
                    // editIsValid가 false인 경우, done버튼 비활성화 + 중복확인
                    // TODO: Location 구현 후 비활성화 설정하기
//                    .disabled(!editIsValid)
                }
            }
            .navigationTitle(Text("Edit Profile"))
            .navigationBarTitleDisplayMode(.inline)
        }// NavigationView 종료
        .onAppear{
            editName = userNickname
            editNation = userNation
        }
        .onTapGesture {
            hideKeyboard()
        }
       
    }
}

extension String {
    func toImage() -> UIImage {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)!
        }
        return UIImage()
    }
}


struct EditMyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditMyProfileView(image: .constant(UIImage()), userNickname: .constant(""), userNation: .constant(""))
            .environmentObject(UserInfoStore())
    }
}
