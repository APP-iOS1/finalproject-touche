//
//  SignUpView.swift
//  ToucheFinal
//
//  Created by MIJU on 2023/01/18.
//

import SwiftUI

struct SignUpView: View {
    enum Field {
        case email
        case password
        case checkPassword
        case nickName
    }
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userInfoStore: UserInfoStore
    
    @State var email: String = ""
    @State private var nickNameCheck: Bool?
    @State var password: String = ""
    @State var checkPassword: String = ""
    @State var nickName: String = ""
    @FocusState private var focusedField: Field?
    
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
        if userInfoStore.isEmailDuplicated == false && isEmailRuleSatisfied &&  isPasswordRuleSatisfied && isPasswordSame && isNickNameSatisfied && !password.isEmpty && !checkPassword.isEmpty {
            return false
        } else { return true }// 하나라도 만족하지 않는다면 disabled
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                // Email
                Group {
                    HStack {
                        Text("Email")
                        // 이메일 형식이고 중복이 아닌 경우에 checkmark 나오기
                        if checkEmail(email: email) == true && userInfoStore.isEmailDuplicated == false {
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
                    
                    TextField("Enter Email", text: $email)
                        .focused($focusedField, equals: .email)
                        .modifier(KeyboardTextField())
                        .keyboardType(.emailAddress) // 이메일용 키보드
                        .submitLabel(.next)
                        .frame(height: 40)
                        .padding(.top, -6)
                    // 이메일 중복체크 후에 텍스트필드에서 수정한 경우 초록체크모양 사라지고 중복 재확인해야 Sign Up 버튼 활성화됨
                        .onChange(of: email) { _ in
                            userInfoStore.isEmailDuplicated = nil
                        }
                    
                    if !isEmailRuleSatisfied {
                        Text("Please enter a vaild email.")
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(.top, -9)
                    } else if userInfoStore.isEmailDuplicated == true {
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
                
                // Password
                Group{
                    Text("Password")
                    
                    SecureField("Enter Password", text: $password)
                        .focused($focusedField, equals: .password)
                        .frame(height: 40)
                        .padding(.top, -6)
                        .textContentType(UITextContentType.username)
                        .submitLabel(.next)
                    
                    Text(isPasswordRuleSatisfied ? "" : "Password must be at least 8 characters.")
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.top, -9)
                    
                    
                    Text("Confirm Password")
                    
                    SecureField("Enter Password again", text: $checkPassword)
                        .focused($focusedField, equals: .checkPassword)
                        .frame(height: 40)
                        .padding(.top, -6)
                        .textContentType(UITextContentType.username)
                        .submitLabel(.next)
                    
                    Text(isPasswordSame ? "" : "Password does not match.")
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.top, -9)
                }
                .padding(.vertical, 1)
                
                // Nick Name
                Group{
                    HStack {
                        Text("Nick Name")
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
                    
                    TextField("Enter Nick Name", text: $nickName)
                        .focused($focusedField, equals: .nickName)
                        .modifier(KeyboardTextField())
                        .keyboardType(.alphabet)
                        .submitLabel(.done)
                        .frame(height: 40)
                        .padding(.top, -6)
                    // 닉네임 중복체크 후에 텍스트필드에서 수정한 경우 초록체크모양 사라지고 중복 재확인해야 Sign Up 버튼 활성화됨
                        .onChange(of: nickName) { _ in
                            nickNameCheck = nil
                        }
                    
                    // nickNameCheck == true:중복된 닉네임 (=이미 존재하는 닉네임)
                    if nickNameCheck == true && !nickName.isEmpty {
                        Text("Already exists.")
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(.top, -9)
                    }
                }
                .padding(.vertical, 1)
            }
            .onTapGesture {
                hideKeyboard()
            }
            .padding()
            .textFieldStyle(.roundedBorder)
            
            
            // Sign Up Button
            Button {
                Task {
                    await userInfoStore.signUp(emailAddress: email, password: password, nickname: nickName)
                    
                    // 향수 디테일 뷰에서 회원 가입 할때 모달창 디스미스 위한 조건문
                    if userInfoStore.loginState == .success {
                        dismiss()
                    }
                }
            } label: {
                Text("Sign Up")
                    .frame(width: 360, height: 46)
                    .background(isSignUpDisabled ? .gray : .black)
                    .foregroundColor(.white)
                    .cornerRadius(7)
            }
            .disabled(isSignUpDisabled)
            .padding(.top, 10)
            
        }
        .onAppear{
            //            print("SignUp")
            // 이메일, 닉네임 옆 초록 체크표시 없애기
            userInfoStore.isEmailDuplicated = nil
            nickNameCheck = nil
            
            focusedField = .email
        }
        .onSubmit {
            switch focusedField {
            case .email:
                focusedField = .password
            case .password:
                focusedField = .checkPassword
            case .checkPassword:
                focusedField = .nickName
            default:
                print("sign up ..")
            }
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
            .environmentObject(UserInfoStore())
    }
}
