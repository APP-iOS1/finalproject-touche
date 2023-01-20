//
//  UserInfoStore.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/17.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth


class UserInfoStore: ObservableObject{
    @Published var userStore: [UserInfo] = []
    let database = Firestore.firestore().collection("User")
    var nickName: String?
    var user: User? {
        didSet { // 저장된 user 정보가 바뀌면 호출되어서 값을 업데이트
            objectWillChange.send()
            print("didSet")
        }
    }
    
    enum SignInState {
        case splash
        case signIn
        case signOut
    }
        
    enum LogInState {
        case success
        case fail
        case none
    }
        
    enum LoginPlatform {
        case email
        case google
        case none
    }
        
    var userEmailList: [String] {
        userStore.map { $0.userId }
    }
    
    var userNickNameList: [String] {
        return userStore.map{ $0.userNickName }
    }
    
        //인증 상태를 관리하는 변수
    @Published var state: SignInState = .splash
    @Published var loginState: LogInState = .none
    @Published var loginPlatform: LoginPlatform = .none
    
    func fetchUser() {
        database.getDocuments { (snapshot, error) in
            self.userStore.removeAll()
            if let snapshot {
                for document in snapshot.documents{
                    let docData = document.data()
                    let userId = document.documentID
                    let userNation = docData["userNation"] as? Nation ?? .RepublicOfKorea
                    let userProfileImage = docData["userProfileImage"] as? String ?? ""
                    let likedComment = docData["likedComment"] as? String ?? "좋아요"
                    let userNickName = docData["userNickName"] as? String ?? "개똥이"
                    let userEmail = docData["userEmail"] as? String ?? "test@test.com"
                    
//                    self.userStore.append(userInfo)
//                    if self.user?.uid == userId {
//                        self.nickName = self.nickName
//                    }
                }
            }
        }
    }
    
    func addUser(_ userInfo: UserInfo) {
        database.document(user?.uid ?? "")
            .setData([
//                "likePerfumes": userInfo.likePerfumes ?? [],
                "userEmail": userInfo.userEmail ,
//                "nation": userInfo.nation ?? "",
                "userNickName": userInfo.userNickName ,
//                "watchList": userInfo.watchList ?? []
            ])
        fetchUser()
    }
    
    func listenToLoginState() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else {
                return
            }
            // 로그인이 되어 있는 상태라면 user property에 user를 할당
            self.user = user
            print("update")
        }
    }
    
    // MARK: - 로그인 메서드
    func logIn(emailAddress: String, password: String) {
        Task {
            do {
                try await Auth.auth().signIn(withEmail: emailAddress, password: password)
                listenToLoginState()
                print("로그인 성공")
            } catch {
//                await handleError(message: "등록되지 않은 사용자 입니다.")
            }
        }
        self.loginState = .success
        
    }
    
    // MARK: - 회원가입 메서드
    // FIXME: 에러처리 필요함
    func signUp(emailAddress: String, password: String, nickname: String) {
        Auth.auth().createUser(withEmail: emailAddress, password: password) { [weak self] result, error in
            if let error = error {
                print("an error occured: \(error.localizedDescription)")
                return
            } else {
                guard let uid = result?.user.uid else { return }
                // MARK: 받아온 닉네임 정보로 사용자의 displayName 설정
                self?.logIn(emailAddress: emailAddress, password: password)
                
                let userInfo = UserInfo(
                    userId: uid,
                    userNation: .None,
                    userNickName: "닉네임이 없어요.",
                    userProfileImage: "",
                    userEmail: emailAddress,
                    writtenComments: []
                )
                
                do {
                    try self?.database.document(userInfo.userId).setData(from: userInfo)
                } catch {
                    return
                }
//                self.addUser(user)
            }
        }
    }
    
    func updateDisplayName(displayName: String) { // (2)
        if let user = Auth.auth().currentUser {
          let changeRequest = user.createProfileChangeRequest() // (3)
          changeRequest.displayName = displayName
          changeRequest.commitChanges { error in // (4)
            if error != nil {
              print("Successfully updated display name for user [\(user.uid)] to [\(displayName)]")
            }
          }
        }
      }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func checkEmail(email: String) -> Bool {
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
            return  NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
        }
    
    func emailDuplicateCheck(_ email: String) -> Bool {
        // 중복이다
        if userEmailList.contains(email) {
            return true
        }
        //중복아니다
        return false
        
 
    }
    
    func nickNameDuplicateCheck(_ nickName: String) -> Bool {
        return userNickNameList.contains(nickName)
    }
}
