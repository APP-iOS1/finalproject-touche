//
//  SignUpView.swift
//  ToucheFinal
//
//  Created by MIJU on 2023/01/18.
//

import SwiftUI
import PopupView

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userInfoStore: UserInfoStore
    
    @State private var isShowingSuccessPopup = false
    @State var email: String = ""
    @State private var emailCheck: Bool?
    @State private var nickNameCheck: Bool?
    @State var password: String = ""
    @State var checkPassword: String = ""
    @State var nickName: String = ""
    
    // 이메일 중복처리 확인
//    var isEmailDuplicatedSatisfied: Bool {
//        return userInfoStore.isDuplicated == true
//    }
    
    // 이메일 정규식 검사
    var isEmailRuleSatisfied : Bool {
        return checkEmail(email: email) || email.isEmpty
    }
        
    // 비밀번호 형식 확인
    var isPasswordRuleSatisfied : Bool {
        return password.count > 7 || password.isEmpty
    }
        
    // 비밀번호 확인
    var isPasswordSame: Bool {
        return ((password == checkPassword) && !password.isEmpty) || checkPassword.isEmpty
    }
    
    // 닉네임 확인 - 중복 false && !nickName.isEmpty
    var isNickNameSatisfied: Bool {
        return nickNameCheck == false && !nickName.isEmpty
    }

    // 회원가입 버튼
    var isSignUpDisabled: Bool {
        
        // 조건을 다 만족하면 회원가입 버튼 abled
        if userInfoStore.isDuplicated == false && isEmailRuleSatisfied &&  isPasswordRuleSatisfied && isPasswordSame && isNickNameSatisfied {
            return false
        } else { return true }// 하나라도 만족하지 않는다면 disabled
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                Group {
                    HStack {
                        Text("Email")
                        if userInfoStore.isDuplicated == false {
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(.green)
                        }
                        Spacer()
                        
                        Button {
                            userInfoStore.duplicateCheck(emailAddress: email)
                        } label: {
                            Text("Check")
                                .underline()
                                .foregroundColor(email.isEmpty ? .gray : .black)
                        }
                        .disabled(email.isEmpty)
                    }
                    TextField("Enter email", text: $email)
                        .textInputAutocapitalization(.never) // 대문자 방지
                        .disableAutocorrection(true) // 자동수정 방지
                        .keyboardType(.emailAddress) // 이메일용 키보드
                        .frame(height: 40)
                        .padding(.top, -6)
                    
                    //MARK: 중복확인을 통과했을 때 어떻게 처리할지?
                    //signup 버튼과 같이 이메일 중복여부를 체크한 이후 텍스트필드에서 입력을 하나 지우면
                    //여전히 중복됐음을 알리는 텍스트가 잔존하는 문제
                    if !isEmailRuleSatisfied {
                        Text("Please enter a vaild email.")
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(.top, -9)
                    } else if userInfoStore.isDuplicated == true {
                        Text("This email address already exists.")
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(.top, -9)
                    }
                    else {
                        Text("")
                            .padding(.top, -9)
                    }
                }
                .padding(.vertical, 1)
                
                Group{
                    Text("Password")
                    
                    SecureField("Enter password", text: $password)
                        .frame(height: 40)
                        .padding(.top, -6)
                        .textContentType(UITextContentType.username)
                    
                    Text(isPasswordRuleSatisfied ? "" : "Passwords must be at least 8 characters.")
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.top, -9)
                    
                    Text("Confirm password")
                    
                    SecureField("Enter password again", text: $checkPassword)
                        .frame(height: 40)
                        .padding(.top, -6)
                        .textContentType(UITextContentType.username)
                    
                    Text(isPasswordSame ? "" : "Passwords do not match.")
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.top, -9)
                }
                .padding(.vertical, 1)
                
                Group{
                    HStack {
                        Text("Nickname")
                        if nickNameCheck == false {
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(.green)
                        }
                        Spacer()
                        Button {
                            Task {
                                do {
                                    let target = try await userInfoStore.isNicknameDuplicated(nickName: nickName)
                                    nickNameCheck = target
                                } catch {
                                    throw(error)
                                }
                            }
                        } label: {
                            Text("Check")
                                .underline()
                                .foregroundColor(nickName.isEmpty ? .gray : .black)
                        }
                        .disabled(nickName.isEmpty)

                    }
                    
                    TextField("Enter user name", text: $nickName)
                        .textInputAutocapitalization(.never) // 대문자 방지
                        .disableAutocorrection(true) // 자동수정 방지
                        .frame(height: 40)
                        .padding(.top, -6)
//                        .padding(.bottom, 10)
                    
                    // 중복된 닉네임-true
                    if nickNameCheck == true && !nickName.isEmpty {
                        Text("Already exists.")
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(.top, -9)
                    }
                }
            }
            .padding()
            .textFieldStyle(.roundedBorder)
            
            
            Button {
                isShowingSuccessPopup.toggle()
                Task {
                    await userInfoStore.signUp(emailAddress: email, password: password, nickname: nickName)
                    userInfoStore.isDuplicated = nil
                }
            } label: {
                Text("Sign Up")
                    .frame(width: 360, height: 46)
                    .background(isSignUpDisabled ? .gray : .black)
                    .foregroundColor(.white)
                    .cornerRadius(7)
            }
            .disabled(isSignUpDisabled)
            
//            Spacer()
        }
        .onAppear{print("SignUp")}
        
        /// 로그인 성공시 알람창
        .popup(isPresented: $isShowingSuccessPopup) {
            Text("success!")
                .bold()
                .frame(width: UIScreen.main.bounds.width - 20, height: 50)
                .background(Color.green.opacity(0.7))
                .cornerRadius(20.0)
        } customize: {
            $0.autohideIn(2)
                .type(.floater())
                .position(.top)
                .animation(.spring())
                .isOpaque(true)
                .closeOnTapOutside(true)
//                .backgroundColor(.black.opacity(0.1))
        }
            
        
        
    }
    func checkEmail(email: String) -> Bool {
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
            return  NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
        }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            
            
    }
}
