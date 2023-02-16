//
//  EditMyProfileView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/18.
//

import SwiftUI
import FirebaseAuth
import SDWebImageSwiftUI
import AVFoundation
import Photos
import Combine

struct EditMyProfileView: View {
    @StateObject var editNickname: TextLimiter = TextLimiter(limit: 12)
    
    @State private var isShowingDialog: Bool = false
    @State private var dialogTitle: String = "Title"
    // 뷰에 반영된건 없는데, confirmationDialog 에서 안쓰면 에러나서 씀
    @State private var showGallerySheet = false
    @State private var showCameraSheet = false
    @State private var editIsValid: Bool =  false
    /// nickName 중복처리 true/false 확인용
    @State private var nickNameCheck: Bool = false
    @State private var editImage: UIImage = UIImage()
    @State private var editNation: String = ""
    /// photo picker로 갤러리에서 이미지 변경시 사용
    @State private var isChangedImage: Bool = false
    
    //  @Binding var image: UIImage
    //@Binding var userNickname: String
    //@Binding var userNation: String
    
    
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
                        .background {
                            Image(systemName: "person.fill")
                                .resizable()
                                .padding(.top, 6)
                                .padding(.horizontal, 3)
                                .foregroundColor(.gray)
                                .clipShape(Circle())
                                .overlay {
                                    Circle()
                                        .stroke(.gray, lineWidth: 0.1)
                                }
                        }
                        .aspectRatio(contentMode: .fill)
                        .padding(.bottom, 10)
                    
                    if isChangedImage == true {
                        Image(uiImage: self.editImage)
                            .resizable()
                            .cornerRadius(50)
                            .frame(width: 100, height: 100)
                            .background(Color.black.opacity(0.2))
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .padding(.bottom, 10)
                    }
                }
                
                Button("Edit Photo"){
                    isShowingDialog = true
                    isChangedImage = true
                }
                .frame(width: UIScreen.main.bounds.width - 310, height: 30)
                .font(.footnote)
                .lineLimit(1)
                .minimumScaleFactor(0.4)
                .foregroundColor(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 5).stroke(Color.black, lineWidth: 0.5)
                        .cornerRadius(5)
                )
                .confirmationDialog(dialogTitle, isPresented: $isShowingDialog){
                    Button("Change from Gallery"){
                        showGallerySheet = true
                        checkAlbumPermission()
                    }
                    
                    Button("Take Photo"){
                        showCameraSheet = true
                        checkCameraPermission()
                    }
                    
                    Button("Cancel",role: .cancel){
                        isShowingDialog = false
                    }
                }
                .padding(.bottom, 15)
                
                Divider()
                    .frame(maxWidth: .infinity)
                
                HStack {
                    VStack {
                        Text("Nickname")
                            .padding(10)
                            .frame(maxWidth: 100, alignment: .leading)
                        Text("Email")
                            .padding(10)
                            .frame(maxWidth: 100, alignment: .leading)
                        Text("Region")
                            .padding(10)
                            .frame(maxWidth: 100, alignment: .leading)
                            .padding(.vertical, 8)
                    }
                    .padding(.leading, 9)
                    
                    VStack {
                        TextField("Edit your Name", text: $editNickname.value)
                            .keyboardType(.alphabet)
                            .modifier(KeyboardTextField())
                        // 닉네임 변경시, 닉네임 개수 0이상 20미만, 닉네임중복 아닐경우 true.
                        //                            .onChange(of: editNickname) { value in
                        //                                if editNickname.count > 0 && editNickname.count < 20 {
                        //                                    self.editIsValid = true
                        //                                } else {
                        //                                    self.editIsValid = false
                        //                                }
                        //                            }
                            .onReceive(Just($editNickname.value)) { val in  //  ref: https://eunjin3786.tistory.com/412
                                print("val: \(val.wrappedValue)")
                                
                                //if (val.wrappedValue != "") {
                                
                                let nickname = val.wrappedValue
                                
                                //userNickname = nickname
                                userInfoStore.userNickname = nickname
                                
                                //}
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(7)
                            .overlay(
                                VStack {
                                    Spacer()
                                    Rectangle().frame(height: 0.8)
                                        .foregroundColor((editNickname.value.isEmpty) || (editNickname.value.count > 12) ? Color(uiColor: .red) : Color(uiColor: .systemGray5))
                                        .overlay {
                                            if (editNickname.value.isEmpty) || (editNickname.value.count > 12) {
                                                HStack {
                                                    Text("Nickname can not be blank!")
                                                        .font(.system(size: 10))
                                                        .offset(y: 6)
                                                        .padding(.leading, 10)
                                                        .foregroundColor(.red)
                                                        .kerning(1)
                                                    
                                                    Spacer()
                                                }
                                            }
                                        }
                                }
                            )
                            .padding(.trailing, 11)
                        
                        Text(userInfoStore.userInfo?.userEmail ?? "")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(7)
                            .overlay(
                                VStack {
                                    Spacer()
                                    Rectangle().frame(height: 0.8)
                                        .foregroundColor(Color(uiColor: .systemGray5))
                                }
                            )
                            .padding(.trailing, 11)
                        
                        HStack {
                            ForEach(0 ..< 5) { idx in
                                Button {
                                    editNation = nation[idx]
                                    print(editNation)
                                } label: {
                                    Text(nation[idx])
                                        .overlay(
                                            Circle().stroke(editNation == nation[idx] ? .green : .clear, lineWidth: 2)
                                        )
                                }
                                .buttonStyle(.customButton)
                                .padding(.trailing, -13)
                            }
                        }
                        
                        .padding(.trailing)
                        .padding(.vertical, 10)
                        .offset(x: -10, y: 10)
                    }
                }
                .padding(.bottom, 20)
                Divider()
                //.frame(minWidth: .infinity)
                Spacer()
            }
            .fullScreenCover(isPresented: $showGallerySheet){
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$editImage)}
            .fullScreenCover(isPresented: $showCameraSheet) {
                ImagePicker(sourceType: .camera, selectedImage: self.$editImage)
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
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
                            
                            //if editNickname.value == "" {
                            // 수정 완료 기능
                            //                                userNickname = editName
                            //                                editNation = editNation
                            
                            //MARK: - 닉네임 Update Method 호출
                            /*
                             await userInfoStore.updateUserNickName(uid: Auth.auth().currentUser?.uid ?? "", nickname: editNickname.value)
                             */
                            
                            //MARK: - 기존 버전
                            /*
                             let strImg = await userInfoStore.uploadPhoto([editImage.pngData() ?? Data()])
                             */
                            
                            //  isChangedImage 얘에 변화가 감지 되었을 때,
                            //if (isChangedImage == true) {   //  isChangedImage
                            //MARK: - (바꾼 버전) editImage를 png화 하여 사진을 Upload하는 (Storage로) 메서드를 호출하고 그 메서드의 반환 타입은 String
                            
                            let strImg: String = await userInfoStore.uploadPhoto(editImage.jpegData(compressionQuality: 0.5))   //  JPEG화
                            
                            print("strImg: \(strImg)")
                            
                            if (editNickname.value != "") {
                                
                                await userInfoStore.updateUserProfile(uid: userInfoStore.user?.uid ?? "", nickname: editNickname.value, nation: editNation, userProfileImageUrl: strImg)   //  strImg[0] -> strImg
                                
                            }
                            
                            //MARK: - User 컬렉션 doc의 'userProfileImage'에 위의 strImg 값을 넘겨줘서 저장
                            //let val: String = await userInfoStore.setProfilePhotoUrl(uid: userInfoStore.user?.uid ?? "", userProfileImageUrl: strImg)
                            
                            //print("val: \(val)")
                            
                            /*
                             let imageUrl = URL(string: val)!
                             
                             //MARK: - Runtime 시점에 오류 발생!
                             //  ref: https://www.inflearn.com/questions/748436/synchronous-url-loading-%EC%98%A4%EB%A5%98
                             
                             //  ref: https://www.reddit.com/r/swift/comments/5m0tdb/is_it_possible_to_convert_url_to_uiimage/
                             let imageData = try! Data(contentsOf: imageUrl)
                             
                             let image = UIImage(data: imageData)
                             
                             if let img = image {
                             
                             editImage = img
                             }
                             */
                            
                            //MARK: - Runtime 에러 URLSession으로 해결
                            //                                if let imageUrl = URL(string: val) {
                            //
                            //                                    URLSession.shared.dataTask(with: imageUrl, completionHandler: { data, _, _ in
                            //
                            //                                        guard let imageData = data else { return }
                            //
                            //                                        DispatchQueue.main.async {  //  UI처리는 무조건 main thread에서 작업한다!
                            //
                            //                                            let image = UIImage(data: imageData)
                            //
                            //                                            if let img = image {
                            //
                            //                                                editImage = img
                            //                                            }
                            //                                        }
                            //                                    })
                            //                                }
                            //}
                            
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
            editNickname.value = userInfoStore.userInfo?.userNickName ?? ""
            editNation = userInfoStore.userInfo?.userNation.flag() ?? ""
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}

// MARK: - 카메라 접근 권한 묻는 함수
func checkCameraPermission(){
    AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
        if granted {
            print("Camera: 권한 허용")
        } else {
            print("Camera: 권한 거부")
        }
    })
}

// MARK: - 앨범 접근 권한 묻는 함수
func checkAlbumPermission(){
    PHPhotoLibrary.requestAuthorization( { status in
        switch status{
        case .authorized:
            print("Album: 권한 허용")
        case .denied:
            print("Album: 권한 거부")
        case .restricted, .notDetermined:
            print("Album: 선택하지 않음")
        default:
            break
        }
    })
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
        Group {
            EditMyProfileView()
                .environmentObject(UserInfoStore())
                .previewDevice("iPhone 13 mini")
            
            EditMyProfileView()
                .environmentObject(UserInfoStore())
                .previewDevice("iPhone 14 Pro")
            
            EditMyProfileView()
                .environmentObject(UserInfoStore())
                .previewDevice("iPhone SE (2nd generation)")
        }
    }
}
