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
    @State private var editBio: String = ""
    
    @Binding var image: UIImage
    @Binding var userNickname: String
    @Binding var userNation: String
    @Binding var bio: String
    
    var nation: [String] = ["🇫🇷 France", "🇯🇵 Japan", "🇰🇷 Republic of Korea", "🇺🇸 United States"]
    
    
    var body: some View {
        NavigationView {
            VStack{
                
                Divider()
                    .frame(width: 390)
                    .offset(y:-17)
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
                    .frame(width: 390)
                
                //
                HStack{
                    VStack(alignment: .leading){
                        Text("ID")
                            .padding(.bottom, 6)
                        Text("Bio")
                            .padding(.bottom, 6)
                        Text("Name")
                            .padding(.bottom, 6)
                        Text("Nation")
                        // 소개
                    }
                    .font(.custom("NotoSans-Light", size: 17.5))
                    VStack(alignment: .leading){
                        TextField("Edit your Nickname", text: $editName)
                            .foregroundColor(.gray)
                            .padding(.bottom,5)
                            .offset(x: 20.5,y: 6)
                        Divider()
                            .frame(width: 295)
                            .offset(x: 15, y: 2)
                            
                        TextField("Introduce Myself", text: $editBio)
                            .offset(x: 20.5, y: 2)
                        Divider()
                            .frame(width: 295)
                            .offset(x: 15, y: 0)
                        Text("Email")
                            .offset(x: 20.5, y: 0)
                        Divider()
                            .frame(width: 295)
                            .offset(x: 15, y: -8)
                        HStack{
                            Button{
                                
                            } label: {
                                    Text("🇰🇷")
                                    
                            }
                            .offset(x: 21, y: -9)
                            Button {
                                
                            } label: {
                                Text("🇺🇸")
                            }
                            .offset(x: 30, y: -9)
                        }
//                        Picker("Select your nations", selection: $editNation){
//                            ForEach(nation, id: \.self){
//                                Text($0)
//                            }
//                        }
//                        .tint(.gray)
                    }
                    .font(.custom("NotoSans-Light", size: 17.5))
                }
                Divider()
                    .frame(width: 390)
                
                Spacer()
                Spacer()
            }//VStack 종료
        
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
                        bio = editBio
                        dismiss()
                        // 수정 완료 기능
                    }
                }
            }
            // MARK: FIX 요청 - 커스텀 폰트 적용 안됨
            .navigationTitle(Text("Edit Profile"))
            .navigationBarTitleDisplayMode(.inline)
        }// NavigationView 종료
        .onAppear{
            editName = userNickname
        }
       
    }
}

struct EditMyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditMyProfileView(image: .constant(UIImage()), userNickname: .constant(""), userNation: .constant(""), bio: .constant(""))
    }
}
