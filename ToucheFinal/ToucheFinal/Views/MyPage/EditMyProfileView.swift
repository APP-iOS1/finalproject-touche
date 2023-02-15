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
    @State private var isShowingDialog: Bool = false
    @State private var dialogTitle: String = "Title"
    // 뷰에 반영된건 없는데, confirmationDialog 에서 안쓰면 에러나서 씀
    @State private var showGallerySheet = false
    @State private var showCameraSheet = false
    @State private var editIsValid: Bool =  false
    /// nickName 중복처리 true/false 확인용
    @State private var nickNameCheck: Bool = false
    //@State private var editNickname: String = ""
    @ObservedObject var editNickname: TextLimiter = TextLimiter(limit: 12)
    @State private var editImage: UIImage = UIImage()
    @State private var editNation: String = ""
    /// photo picker로 갤러리에서 이미지 변경시 사용
    @State private var isChangedImage: Bool = false
    @State private var isSelected: [Bool] = [false, false, false, false, false]
    
    //  @Binding var image: UIImage
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
                
                VStack{
                    HStack{
                        Text("Nickname")
                        Spacer(minLength: 50)
                        
                        VStack{
                            TextField("Edit your Nickname", text: $editNickname.value)
                                .padding(.bottom, -5)
                                .foregroundColor(.black)
                                //.border(Color.red, width: $editNickname.hasReachedLimit.wrappedValue ? 1 : 0)
                            // 닉네임 변경시, 닉네임 개수 0이상 20미만, 닉네임중복 아닐경우 true.
                            /*
                                .onChange(of: editNickname) { value in
                                    if (editNickname.value.count > 0 && editNickname.value.count < 13) {
                                        self.editIsValid = true
                                    } else {
                                        self.editIsValid = false
                                    }
                                }
                             */
                                .onReceive(Just($editNickname.value)) { val in  //  ref: https://eunjin3786.tistory.com/412
                                    print("val: \(val.wrappedValue)")
                                    
                                    let nickname = val.wrappedValue
                                    
                                    userNickname = nickname
                                }
                                //  .textInputAutocapitalization(.never)    //  textfield 입력시 무조건 소문자로만 입력 됨
                            
                            if ((userNickname.isEmpty) || (userNickname.count > 12)) {
                                Rectangle().frame(height: 0.45)
                                //  .foregroundColor(Color(uiColor: .systemGray5))
                                    .foregroundColor(Color(uiColor: .red))
                            } else {
                                
                                Rectangle().frame(height: 0.45)
                                    .foregroundColor(Color(uiColor: .systemGray5))
                            }
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
                                        for idx in isSelected.indices {
                                            
                                            isSelected[idx] = false
                                        }
                                        
                                        isSelected[idx].toggle()
                                        userNation = nation[idx]
                                    } label: {
                                        Text(nation[idx])
                                            .overlay(
                                                //  Circle().stroke(editNation == nation[idx] ? .green : .clear, lineWidth: 2)
                                                
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
//                                editNation = editNation
//                            }
                            
                            //MARK: - 닉네임 Update Method 호출
                            if (editNickname.value != "") {
                                await userInfoStore.updateUserNickName(uid: Auth.auth().currentUser?.uid ?? "", nickname: editNickname.value) //  nickname 업데이트 할 때, 공백처리는 해주었는데, regex는 적용 못시켜봄(-> 수요일 도전 예정)
                            } else {
                                
                                print("입력 좀...")
                            }
                            
                            //MARK: - 기존 버전
                            /*
                            let strImg = await userInfoStore.uploadPhoto([editImage.pngData() ?? Data()])
                             */
                            
                            if (isChangedImage == true) {
                                //MARK: - (바꾼 버전) editImage를 png (or JPEG)화 하여 사진을 Upload하는 (Storage로) 메서드를 호출하고 그 메서드의 반환 타입은 String
                                //let strImg: String = await userInfoStore.uploadPhoto(editImage.pngData()) //  png화
                                let strImg: String = await userInfoStore.uploadPhoto(editImage.jpegData(compressionQuality: 0.5))   //  JPEG화
                                
                                print("strImg: \(strImg)")
                                
                                //MARK: - User 컬렉션 doc의 'userProfileImage'에 위의 strImg 값을 넘겨줘서 저장
                                let val: String = await userInfoStore.setProfilePhotoUrl(uid: userInfoStore.user?.uid ?? "", userProfileImageUrl: strImg)
                                
                                print("val: \(val)")
                                
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
                                if let imageUrl = URL(string: val) {
                                    
                                    URLSession.shared.dataTask(with: imageUrl, completionHandler: { data, _, _ in
                                        
                                        guard let imageData = data else { return }
                                        
                                        DispatchQueue.main.async {  //  UI처리는 무조건 main thread에서 작업한다!
                                            
                                            let image = UIImage(data: imageData)
                                            
                                            if let img = image {
                                                
                                                editImage = img
                                            }
                                        }
                                    })
                                }
                            } else {
                                
                                print("Nope")
                            }
                            
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
            /*
            editName = userInfoStore.userInfo?.userNickName ?? ""
            editNation = userInfoStore.userInfo?.userNation.flag() ?? ""
             */
            
            editNickname.value = userNickname
            //print("editName: \(editName)")
            
            editNation = userNation
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
        EditMyProfileView(userNickname: .constant(""), userNation: .constant(""))
            .environmentObject(UserInfoStore())
    }
}
