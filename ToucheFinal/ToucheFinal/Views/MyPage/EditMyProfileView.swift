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
            VStack{
                
                Text("Edit Profile")
                    .padding(.bottom,20)
                
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
                
                Divider()
                
                HStack{
                    VStack (alignment: .trailing){
                        Text("Name")
                            .padding(.bottom, 10)
                        Text("ID")
                            .padding(.bottom, 10)
                        Text("Nation")
                    }
                    
                    Spacer(minLength: 15)
                    VStack(alignment: .leading){
                        HStack {
                            TextField("Edit your Nickname", text: $editName)
                                .foregroundColor(.black)
                                .padding(.bottom,10)
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
                        Text("사용자 가입 디폴트 email, 수정 불가")
                            .foregroundColor(.gray)
                        Picker("Select your nations", selection: $editNation){
                            ForEach(nation, id: \.self){
                                Text($0)
                            }
                        }
                        .tint(.gray)
                    }
                }
                Spacer()
                Spacer()
            }
            .padding(15)
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
        }
        .onAppear{
            editName = userNickname
        }
    }
}

//struct EditMyProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditMyProfileView()
//    }
//}
