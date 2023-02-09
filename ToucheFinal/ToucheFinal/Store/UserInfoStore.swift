//
//  UserInfoStore.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/17.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import UIKit

/// 유저정보를 다루는 store
@MainActor
final class UserInfoStore: ObservableObject{
    @Published var userInfo: UserInfo?
    @Published var recentlyPerfumesId: [String] = []
    @Published var notice = ""
    @Published var errorMessage = ""
    @Published var isDuplicated: Bool?
    @Published var writtenCommentsAndPerfumes: [(Perfume, Comment)] = []
    @Published var isShowingFailAlert = false
    @Published var isShowingSuccessAlert = false
    
    private let database = Firestore.firestore().collection("User")
    
    //  storage 참조변수
    private let storageRef = Storage.storage().reference()
    lazy var userNickname = Auth.auth().currentUser?.displayName ?? ""
    
    var currentUser = Auth.auth().currentUser?.uid
    var user: User? {
        didSet { // 저장된 user 정보가 바뀌면 호출되어서 값을 업데이트
            objectWillChange.send()
            notice = "didSet"
//            currentUserNickname = Auth.auth().currentUser?.displayName
            currentUser = Auth.auth().currentUser?.uid
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
    
    /// 상태변수들 ( 잘 안사용? )
    @Published var state: SignInState = .splash
    @Published var loginState: LogInState = .none
    @Published var loginPlatform: LoginPlatform = .none
    @Published var signInState: SignInState = .signOut
    
    /// 현재 로그인한 사용자의 `UserInfo`를 Firestore로 부터 읽어오는 함수
    /// - Parameter user: 특정 회원의 `uid`를 이용하기 위한 파라미터 (User? 타입)
    ///
    /// - 유저의 `uid`를 이용해 Firestore의 uid document에서 데이터를 불러온다.
    func fetchUser(user: User?) async {
        guard let uid = user?.uid else { return }
        do {
            let snapshot = try await database.document(uid).getDocument()
            userInfo = try snapshot.data(as: UserInfo.self)
            self.notice = "fetchUser"
        } catch {
        }
    }
    
    /// 이 클래스가 실행하면, 먼저 로그인 여부를 따져서 이전에 로그인했으면 자동 로그인을 지원한다.
    ///
    /// 참고링크 : [링크](https://github.com/FirebaseExtended/firebase-video-samples/blob/main/fundamentals/apple/auth-gettingstarted/final/Favourites/Shared/Auth/AuthenticationViewModel.swift)
    init() {
        listenToLoginState()
    }
    
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    
    /// 로그인을 했으면, 앱을 껏다 켜도 자동 로그인됌 -> log out이후에는 자동로그인 안됌.
    func listenToLoginState() {
        if authStateHandler == nil {
            authStateHandler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
                guard let self = self else {
                    return
                }
                self.user = user
                self.notice = "update"
            }
        }
    }
    
    /// 로그인 기능
    /// - Parameters:
    ///   - emailAddress: 사용자의 email
    ///   - password: 사용자의 password
    ///
    ///  - 로그인이 성공하면, 자동으로 현재 사용자의 `UserInfo`를 할당함.
    func logIn(emailAddress: String, password: String) async {
        do {
            let result = try await Auth.auth().signIn(withEmail: emailAddress, password: password)
            await fetchUser(user: result.user)
            self.loginState = .success
            self.notice = "login"
        } catch {}
    }
    
    
    /// 회원가입 기능
    /// - Parameters:
    ///   - emailAddress: 사용자의 email
    ///   - password: 사용자의 password
    ///   - nickname: 사용자의 닉네임
    ///
    /// - 1) 회원가입이 실패하면 회원가입기능 실패
    /// - 2) 회원가입이 성공하면 회원가입절차는 아래와 같다.
    ///     a. 가입된 유저의 User? 데이터를 이용해, `uid`값을 가져온다.
    ///     b. 가입된 유저를 별도의 로그인 절차없이, 로그인 시킨다.
    ///     c. 가입된 유저의 정보를 `UserInfo`데이터모델로 생성한다.
    ///     d. 생성한 `UserInfo`데이터모델을 Firestore에 "./User/{uid}/"경로에 저장한다.
    ///     e. 현재 가입한 유저의 `userInfo`정보를 최신화 한다.
    func signUp(emailAddress: String, password: String, nickname: String) async {
        do {
            // MARK: 회원가입 성공하면, uid 받아오기.
            let result = try await Auth.auth().createUser(withEmail: emailAddress, password: password)
            // MARK: 곧바로 로그인.
            await logIn(emailAddress: emailAddress, password: password)
            
            // MARK: UserInfo로 변환
            guard let uid = user?.uid else {return}
            // MARK: Firestore에 User Collection에 저장.
            try await database.document(uid).setData([
                "userId": uid,
// <<<<<<< 0206/EditMyProfileStorage/SKH
//                "userNation": Nation.None.rawValue,
//                =======
                "userNation": "",
                "userNickName": nickname,
                "userProfileImage": "",
                "userEmail": emailAddress,
                "writtenComments": [],
                "recentlyPerfumesId": []])
            // MARK: 현재 유저의 userInfo 불러오기
            print("// MARK: 현재 유저의 userInfo 불러오기")
            await fetchUser(user: result.user)
        } catch { }
                
    }
    
    /// 로그아웃 기능
    func logOut() {
        do {
            try Auth.auth().signOut()
            userInfo = nil
            user = nil
            currentUser = nil
            self.loginState = .none
        } catch let signOutError {
            notice = "Error signing out: \(signOutError.localizedDescription)"
        }
    }
    
    /// 계정 삭제 기능
    func deleteAccount() {
        //  user?.delete()
        user = Auth.auth().currentUser
        
        user?.delete { error in
            if let e = error {
                print(e.localizedDescription)
            } else {
                print("user deleted successfully")
               //self.showingDeleteConfirmation = false
            }
        }
        
        self.signInState = .signOut
        
        database.document(user?.uid ?? "").delete()
    }
    
    // SceneDelegate를 통해 deleteAccount 시 앱 초기화면으로 이동
//    func navigationToInitialView() {
//            let perfumeTabView = PerfumeTabView()
//            let window = UIApplication.shared.windows.first { $0.isKeyWindow }
//            window?.rootViewController = UIHostingController(rootView: NavigationView {
//                perfumeTabView
//            })
//        }
    
    /// 이메일 중복 체크
    func duplicateCheck(emailAddress: String) {

            Auth.auth().fetchSignInMethods(forEmail: emailAddress) { providers, error in
                if let error {
                    print(error.localizedDescription)
                } else if providers != nil {
                    print("이미 등록된 이메일 입니다.")
                    self.isDuplicated = true
                    print("조건문의 isDuplicated 값은 (self.isDuplicated)")
                } else {
                    print("계정 정보가 없습니다.")
                    self.isDuplicated = false
                }
            }
    }

    /// 닉네임 중복확인을 해주는 함수
    final func isNicknameDuplicated(nickName: String) async throws -> Bool {
        do {
            let target = try await database.whereField("userNickName", isEqualTo: nickName).getDocuments()
            
            if target.isEmpty {
                print("중복되지 않은 닉네임")
                return false //중복되지 않은 닉네임
            } else {
                print("중복된 닉네임")
                return true //중복된 닉네임
            }
        } catch {
            throw(error)
        }
    }
    
    /// 사용 중인 유저의 닉네임을 반환
    final func getNickName(uid: String) async -> String {
        do {
            let target = try await database.document("\(uid)").getDocument()
            
            let docData = target.data()
            let tmpName: String = docData?["userNickName"] as? String ?? ""
            
            print("유저닉네임: \(tmpName)")
            return tmpName
        } catch {
            print(error.localizedDescription)
            return "error"
        }
    }
    
    /// 사용 중인 유저의 닉네임을 수정
    final func updateUserNickName(uid: String, nickname: String) async -> Void {
        let path = database
        do {
            try await path.document(uid).updateData(["userNickName": nickname])
        } catch {
#if DEBUG
            print("\(error.localizedDescription)")
#endif
        }
    }

    func updateRecentlyPerfumes(recentlyPerfumesId: [String]) async {
        do {
            guard let userId = user?.uid else {return}
            try await database.document(userId)
                .updateData(["recentlyPerfumesId": recentlyPerfumesId])
        } catch {}
    }
    
    func updateWrittenComment(perfumeId: String, commentId: String) async {
        guard let uid = user?.uid else {return}
        do {
            userInfo?.writtenComments.append("\(perfumeId) \(commentId)")
            try await database.document("\(uid)")
                .updateData(["writtenComments": userInfo?.writtenComments ?? []])
        } catch {}
    }
    
    func readWrittenComments() async {
        let path = Firestore.firestore().collection("Perfume")
        do {
            var tempCommentAndPerfume: [(Perfume, Comment)] = []
            for commentId in userInfo?.writtenComments ?? [] {
                let perfumeId = commentId.components(separatedBy: " ")[0]
                let commentId = commentId.components(separatedBy: " ")[1]
                let commentSnapshot = try await path.document(perfumeId).collection("Comment").document(commentId).getDocument()
                let comment = try commentSnapshot.data(as: Comment.self)
                
                let perfumeSnapshot = try await path.document(perfumeId).getDocument()
                let perfume = try perfumeSnapshot.data(as: Perfume.self)
                tempCommentAndPerfume.append((perfume, comment))
                }
            writtenCommentsAndPerfumes = tempCommentAndPerfume
        } catch {}
    }
    
    func deleteWrittenComment(perfumeId: String, commentId: String) async {
        let path = Firestore.firestore().collection("User")
        guard let uid = user?.uid else {return}
        guard let index = userInfo?.writtenComments.firstIndex(of: "\(perfumeId) \(commentId)") else {return}
        do {
            userInfo?.writtenComments.remove(at: index)
            try await path.document(uid)
                .updateData(["writtenComments": userInfo?.writtenComments ?? []])
        } catch {}
    }
    
    // storage에 사진이 올라가는 메서드
    func uploadPhoto(_ imagesData: [Data]) async -> [String] {
        do{
            print("사진 업로드 시작")
            
            var imagesURL: [String] = []
            if imagesData.isEmpty { return [] }
            
            for imageData in imagesData {
                let uuid = UUID().uuidString
                let path = "images/\(uuid).jpg"
                let fileRef = storageRef.child(path)
                
                _ = try await fileRef.putDataAsync(imageData, metadata: nil) // 올리는 과정
                let url = try await fileRef.downloadURL()
                imagesURL.append(url.absoluteString)
                
                print("사진 업로드 성공: \(imagesURL)")
                
                await fetchUser(user: Auth.auth().currentUser)
                print("신규가입자: \(userInfo?.userProfileImage)")
                
                // delPath에서 오류나는 이유는 신규가입자일 경우, storage에 저장한 프로필이미지id가 없으니까 path를 못찾기때문
                // 신규가입자일 경우는 사진추가(업로드)만 하고, 프로필이미지를 한번이라도 변경한 경우에만 delete를 한 후에 업로드하기
                if !(userInfo?.userProfileImage == "") {
                    let delPath = "images/\(String( userInfo?.userProfileImage.split(separator: "%2F")[1].split(separator: "?")[0] ?? ""))"
                    print("path: \(delPath)")
                    try await storageRef.child(delPath).delete()
                }
                
            }
            return imagesURL
            
        } catch{
            print("사진 업로드 실패")
            fatalError()
        }
    }
    
    func setProfilePhotoUrl(uid: String, userProfileImageUrl: String) async -> Void {
            let path = database
            do {
                try await path.document(uid).updateData(["userProfileImage": userProfileImageUrl])
            } catch { }
        }
    
    func setProfileNationality(uid: String, nation: String) async -> Void {
        
        do {
            
            try await database.document(uid).updateData(["userNation" : nation])
        } catch {
            
        }
    }

}
