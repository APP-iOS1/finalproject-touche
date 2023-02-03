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
            GeometryReader{ geometry in
            VStack{
                
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
                

            }//VStack 종료
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
                        image = editImage
                        userNickname = editName
                        userNation = editNation
            
                        dismiss()
                        // 수정 완료 기능
                    }
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
