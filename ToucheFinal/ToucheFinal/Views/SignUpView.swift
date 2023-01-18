//
//  SignUpView.swift
//  ToucheFinal
//
//  Created by MIJU on 2023/01/18.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var email: String = ""
    @State var password: String = ""
    @State var checkPassword: String = ""
    @State var nickName: String = ""
    
    @Binding var user: Bool
    
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

    // 회원가입 버튼
    var isSignUpDisabled: Bool {
        
        // 조건을 다 만족하면 회원가입 버튼 abled
        if isEmailRuleSatisfied &&  isPasswordRuleSatisfied && isPasswordSame && !nickName.isEmpty {
            return false
        } else { return true }// 하나라도 만족하지 않는다면 disabled
    }

    var body: some View {
        VStack{
            VStack(alignment: .leading){
                Group {
                    Text("Email")
                    
                    TextField("Enter email", text: $email)
                        .frame(height: 40)
                        .padding(.top, -6)
                        
                    Text(!isEmailRuleSatisfied ? "Please enter a vaild email." : "")
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.top, -9)
                }
                .padding(.vertical, 1)
                
                Group{
                    Text("Password")
                    
                    SecureField("Enter Password", text: $password)
                        .frame(height: 40)
                        .padding(.top, -6)
                    
                    Text(isPasswordRuleSatisfied ? "" : "Passwords must be at least 8 characters.")
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.top, -9)
                    
                    Text("Confirm password")
                    
                    SecureField("Enter password again", text: $checkPassword)
                        .frame(height: 40)
                        .padding(.top, -6)
                    
                    Text(isPasswordSame ? "" : "Passwords do not match.")
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.top, -9)
                }
                .padding(.vertical, 1)
                
                Group{
                    Text("User name")
                    
                    TextField("Enter user name", text: $nickName)
                        .frame(height: 40)
                        .padding(.top, -6)
                        .padding(.bottom, 10)
                }
            }
            .padding()
            .textFieldStyle(.roundedBorder)
            
            Button {
                user = true
            } label: {
                Text("Sign Up")
                    .frame(width: 360, height: 46)
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(7)
            }
            .disabled(isSignUpDisabled)
        }.onAppear{print("SignUp")}
        
    }
    func checkEmail(email: String) -> Bool {
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
            return  NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
        }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(user: .constant(true))
            
            
    }
}
