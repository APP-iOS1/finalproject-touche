//
//  UserInfoStore.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/17.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

/// 유저정보를 다루는 store
final class UserInfoStore: ObservableObject{
    @Published var userInfo: UserInfo?
    @Published var recentlyPerfumesId: [String] = []
    @Published var notice = ""
    private let database = Firestore.firestore().collection("User")
    var user: User? {
        didSet { // 저장된 user 정보가 바뀌면 호출되어서 값을 업데이트
            objectWillChange.send()
            notice = "didSet"
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
    func fetchUser(user: User?) {
        guard let uid = user?.uid else { return }
        database.document(uid).getDocument { [weak self] snapshot, _ in
            if let snapshot = snapshot {
                do {
                    self?.userInfo = try snapshot.data(as: UserInfo.self)
                } catch {
                    return
                }
            }
        }
        self.notice = "fetchUser"
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
    func logIn(emailAddress: String, password: String) {
        Auth.auth().signIn(withEmail: emailAddress, password: password, completion: { result, _ in
            self.fetchUser(user: result?.user)
        })
        self.loginState = .success
        self.notice = "login"
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
    func signUp(emailAddress: String, password: String, nickname: String) {
        Auth.auth().createUser(withEmail: emailAddress, password: password) { [weak self] result, error in
            if let error = error {
                self?.notice = "an error occured: \(error.localizedDescription)"
                return
            } else {
                // MARK: 회원가입 성공하면, uid 받아오기.
                guard let uid = result?.user.uid else { return }
                // MARK: 곧바로 로그인.
                self?.logIn(emailAddress: emailAddress, password: password)
                // MARK: UserInfo로 변환
                let userInfo = UserInfo(
                    userId: uid,
                    userNation: .None,
                    userNickName: nickname,
                    userProfileImage: "",
                    userEmail: emailAddress,
                    writtenComments: [],
                    recentlyPerfumesId: []
                )
                // MARK: Firestore에 User Collection에 저장.
                do {
                    try self?.database.document(userInfo.userId).setData(from: userInfo)
                } catch {
                    return
                }
                // MARK: 현재 유저의 userInfo 불러오기
                self?.fetchUser(user: result?.user)
            }
        }
    }
    
    /// 로그아웃 기능
    func logOut() {
        do {
            try Auth.auth().signOut()
            userInfo = nil
            user = nil
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
            }
        }
        
        self.signInState = .signOut
        
        database.document(user?.uid ?? "").delete()
    }
    
    func updateRecentlyPerfumes() {
        database.document()
//            .setData([])
    }
}
