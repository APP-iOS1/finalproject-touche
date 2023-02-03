//
//  EditMyProfileView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/18.
//

import SwiftUI
import FirebaseAuth

struct EditMyProfileView: View {
    @State private var isShowingDialog: Bool = false
    @State private var dialogTitle: String = "Title"
    // 뷰에 반영된건 없는데, confirmationDialog 에서 안쓰면 에러나서 씀
    @State private var showGallerySheet = false
    @State private var showCameraSheet = false
    @State private var editName: String = ""
    @State private var editIsValid: Bool =  false
    @State private var nickNameCheck: Bool = false
    @State private var editImage: UIImage = UIImage()
    @State private var editNation: String = ""
  
    
    @Binding var image: UIImage
    @Binding var userNickname: String
    @Binding var userNation: String
   
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userInfoStore: UserInfoStore
    var nation: [String] = ["🇫🇷 France", "🇯🇵 Japan", "🇰🇷 Republic of Korea", "🇺🇸 United States"]
    
    
    var body: some View {
        NavigationView {
            GeometryReader{ geometry in
            VStack{
                Text("Edit Profile")
                    .padding(.bottom,20)

                Divider()
                    .frame(width: 390)
                    .padding(.bottom, 15)
                    

                Image(uiImage: self.editImage)
                    .resizable()
                    .cornerRadius(50)
                    .frame(width: 100, height: 100)
                    .background(Color.black.opacity(0.2))
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .padding(.bottom, 20)
                
                Button("Edit Picture"){
                    isShowingDialog = true
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
                
                //
                
                VStack(alignment: .leading){
                    HStack{
                        Text("Name")
                            .font(.system(size: 19))
                            .padding(.trailing, 35)
                        TextField("Edit your Nickname", text: $editName)
                            .foregroundColor(.gray)
                            // 닉네임 변경시, 닉네임 개수 0이상 20미만, 닉네임중복 아닐경우 true.
                                .onChange(of: editName) { value in
                                    if editName.count > 0 && editName.count < 20 {
                                        self.editIsValid = true
                                    } else {
                                        self.editIsValid = false
                                    }
                                }
                            // TODO:
                            Spacer()
                            Button {
                                editName = ""
                            } label: {
                                Image(systemName: "xmark")
                                    .foregroundColor(.gray)
                            }
                            // 인스타처럼 밑줄 그어주기 ?
                        }
                    }
                    .padding()
                    Divider()
                        .offset(x: geometry.size.width / 3.9)
                       
                    HStack{
                        Text("Email")
                            .font(.system(size: 19))
                            .padding(.trailing, 39)
                        Text("Email")
                    }
                    .padding()
                    Divider()
                        .offset(x: geometry.size.width / 3.9)
                       
                    HStack{
                        Text("Location")
                            .font(.system(size: 19))
                            .padding(.trailing, 35)
                            .offset(x: geometry.size.width / 22, y: geometry.size.height / 300)
                        Button{
                            editNation = "🇺🇸"
                        } label: {
                        Text("🇺🇸")
                        }
                        .buttonStyle(.customButton)
                        .offset(x: geometry.size.width / -25)
                        
                        Button {
                            editNation = "🇰🇷"
                        } label: {
                            Text("🇰🇷")
                        }
                        .buttonStyle(.customButton)
                        .offset(x: geometry.size.width / -15)
                    }
                }
                Divider()
                    .frame(maxWidth: .infinity)
                

//            }//VStack 종료
        } // Geometry 종료
            
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
                            // TODO: 닉네임 수정시 중복확인하는 부분 done에서는 안돼는 상황
//                            do {
//                                let target = try await userInfoStore.isNicknameDuplicated(nickName: editName)
//                                nickNameCheck = target
//                            } catch {
//                                throw(error)
//                            }
                            
                            if editIsValid {
                                // 수정 완료 기능
                                image = editImage
                                userNickname = editName
                                userNation = editNation
                                dismiss()
                                await userInfoStore.updateUserNickName(uid: Auth.auth().currentUser?.uid ?? "", nickname: userNickname)
                            }
                        }
                    }
                    // editIsValid가 false인 경우, done버튼 비활성화 + 중복확인
                    .disabled(!editIsValid)
                    // TODO: done - disable 설정하기, 닉네임설정 후 활성화 + 중복확인 기능 추가
                }
            }
            .navigationTitle(Text("Edit Profile"))
            .navigationBarTitleDisplayMode(.inline)
        }// NavigationView 종료
        .onAppear{
            editName = userNickname
            editNation = userNation
        }
       
    }
}

struct EditMyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditMyProfileView(image: .constant(UIImage()), userNickname: .constant(""), userNation: .constant(""))
    }
}
