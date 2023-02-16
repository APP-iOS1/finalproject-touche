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
    @State var sendMailAlertActive: Bool = false
    @State var isCheckedTermsAndConditions: Bool = false
    @State var isCheckedPrivacy: Bool = false
    @State var isShowingSheet: Bool = false
    @State var modalName = ""
    
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
        if userInfoStore.isEmailDuplicated == false && isEmailRuleSatisfied &&  isPasswordRuleSatisfied && isPasswordSame && isNickNameSatisfied && !password.isEmpty && !checkPassword.isEmpty && isCheckedPrivacy && isCheckedTermsAndConditions {
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
                    }
                    
                    HStack {
                        TextField("Enter Email", text: $email)
                            .focused($focusedField, equals: .email)
                            .modifier(KeyboardTextField())
                            .keyboardType(.emailAddress) // 이메일용 키보드
                            .submitLabel(.next)
                        // 이메일 중복체크 후에 텍스트필드에서 수정한 경우 초록체크모양 사라지고 중복 재확인해야 Sign Up 버튼 활성화됨
                            .onChange(of: email) { _ in
                                userInfoStore.isEmailDuplicated = nil
                            }
                        Button {
                            userInfoStore.duplicateCheck(emailAddress: email)
                        } label: {
                            Text("Check")
                                .foregroundColor(email.isEmpty ? .gray : .white)
                        }
                        .disabled(email.isEmpty)
                        .buttonStyle(.borderedProminent)
                        .tint(.black)
                        
                    }
                    .padding(.top, -6)
                    .frame(height: 40)
//                    .border(.black)
                    
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
                        Text("NickName")
                        if nickNameCheck == false {
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(.green)
                        }
                    }
//                        Spacer()
//                        Button {
//                            Task {
//                                do {
//                                    let target = try await userInfoStore.isNicknameDuplicated(nickName: nickName)
//                                    nickNameCheck = target
//                                } catch {
//                                    throw(error)
//                                }
//                            }
//                        } label: {
//                            Text("Check")
//                                .underline()
//                                .foregroundColor(nickName.isEmpty ? .gray : .black)
//                        }
//                        .disabled(nickName.isEmpty)
                        
                    HStack {
                        TextField("Enter Nick Name", text: $nickName)
                            .focused($focusedField, equals: .nickName)
                            .modifier(KeyboardTextField())
                            .keyboardType(.alphabet)
                            .submitLabel(.done)
                            .frame(height: 40)
                        // 닉네임 중복체크 후에 텍스트필드에서 수정한 경우 초록체크모양 사라지고 중복 재확인해야 Sign Up 버튼 활성화됨
                            .onChange(of: nickName) { _ in
                                nickNameCheck = nil
                            }
                        
                        Button {
                            Task {
                                nickNameCheck = try await userInfoStore.isNicknameDuplicated(nickName: nickName)
                            }
                        } label: {
                            Text("Check")
                                .foregroundColor(nickName.isEmpty ? .gray : .white)
                        }
                        .disabled(nickName.isEmpty)
                        .buttonStyle(.borderedProminent)
                        .tint(.black)
                    }
                    .padding(.top, -6)
                    .frame(height: 40)

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
            
            //            NavigationLink {
            //                ConfirmEmailView()
            //            } label: {
            
            
            /// 회원 이용 약관: TermsandConditionView
            ///(Required) I have read and agree to all the terms and conditions. Terms and conditions -> (필수) 약관을 모두 읽고 동의합니다. 이용약관
            ///
            /// 개인정보 처리방침: Privacy policy
            /// (Required) I agree to the collection and use of personal infomation. Privacy policy -> (필수) 개인정보 수집 ・ 이용에 동의합니다. 개인정보 수집 ・ 이용 동의
            Group {
                VStack(alignment: .leading, spacing: 15) {
                    HStack() {
                        Button {
                            isCheckedTermsAndConditions.toggle()
                        } label: {
                            Label("Checkbox terms and conditions", systemImage: isCheckedTermsAndConditions ? "checkmark.square.fill" : "square")
                                .labelStyle(.iconOnly)
                                .font(.title2)
                                .foregroundColor(isCheckedTermsAndConditions ? .green : .gray)
                        }
                        
                        Text("(Required) I have read and agree to all the terms and conditions. ")
                            .font(.subheadline)
                            .padding(.leading, 15)
                    }
                    Button {
                        modalName = "terms"
                        isShowingSheet.toggle()
                    } label: {
                        Text("Terms and conditions")
                            .font(.subheadline)
                            .underline()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .foregroundColor(.black)
                    }
                }
                .padding(20)
                
                VStack(alignment: .leading, spacing: 15) {
                    HStack() {
                        Button {
                            isCheckedPrivacy.toggle()
                        } label: {
                            Label("Checkbox privacy policy", systemImage: isCheckedPrivacy ? "checkmark.square.fill" : "square")
                                .labelStyle(.iconOnly)
                                .font(.title2)
                                .foregroundColor(isCheckedPrivacy ? .green : .gray)
                        }
                        
                        
                        Text("(Required) I agree to the collection and use of personal infomation. ")
                            .padding(.leading, 15)
                    }
                    Button {
                        modalName = "privacy"
                        isShowingSheet.toggle()
                    } label: {
                        Text("Privacy policy")
                            .underline()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .foregroundColor(.black)
                    }
                    
                }
                .font(.subheadline)
                .padding(20)
            }
            
            Button {
                Task {
                    print("회원가입 버튼")
                    await userInfoStore.signUp(emailAddress: email, password: password, nickname: nickName)
                    userInfoStore.isEmailDuplicated = nil
                    await userInfoStore.sendVerificationEmail()
                    // 향수 디테일 뷰에서 회원 가입 할때 모달창 디스미스 위한 조건문
                    //                        if userInfoStore.loginState == .success {
                    sendMailAlertActive.toggle()
                    
                    //                        }
                    
                }
            } label: {
                Text("Sign Up")
                    .frame(width: UIScreen.main.bounds.width - 30, height: 46)
                    .background(isSignUpDisabled ? .gray : .black)
                    .foregroundColor(.white)
                    .cornerRadius(7)
            }
            .disabled(isSignUpDisabled)
            //            }
            
            
            
            
        }
        .onAppear{
            print("SignUp")
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
        .alert("Your mail has been sent. Please click the link in the mail you received to complete sign up.", isPresented: $sendMailAlertActive) {
            Button("OK"){
                presentationMode.wrappedValue.dismiss()
            }
        } message: {
            Text("Your mail has been sent. Please click the link in the mail you received to complete sign up.")
        }
        .sheet(isPresented: $isShowingSheet) {
            modalName = ""
        } content: {
            switch modalName {
            case "terms":
                TermsandConditionsView()
            case "privacy":
                PrivacyView()
            default:
                Text("")
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
