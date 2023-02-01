//
//  EditMyProfileView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/18.
//

import SwiftUI

struct EditMyProfileView: View {
    
    @Environment(\.dismiss) var dismiss
    // 취소
    @State private var isShowingDialog: Bool = false
    @State private var dialogTitle: String = "Title"
    // 뷰에 반영된건 없는데, confirmationDialog 에서 안쓰면 에러나서 씀
    @State private var showGallerySheet = false
    @State private var showCameraSheet = false
    @State private var editName: String = ""
    @State private var editImage: UIImage = UIImage()
    @State private var editNation: String = ""
    
    @Binding var image: UIImage
    @Binding var userNickname: String
    @Binding var userNation: String
    
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
                        TextField("Edit your Nickname", text: $editName)
                            .foregroundColor(.gray)
                            .padding(.bottom,10)
                        Text("사용자 가입 디폴트 email, 수정 불가")
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
                        image = editImage
                        userNickname = editName
                        userNation = editNation
                        dismiss()
                        // 수정 완료 기능
                    }
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
