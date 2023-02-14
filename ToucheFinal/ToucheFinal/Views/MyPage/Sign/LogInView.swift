//
//  LogInView.swift
//  ToucheFinal
//
//  Created by MIJU on 2023/01/18.
//

import SwiftUI
import AlertToast
import FirebaseAuth

struct LogInView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var isShowingAlert: Bool = false
    @State var loginFailActive: Bool = false
    @FocusState private var isFocused: Bool
    
    @EnvironmentObject var userInfoStore: UserInfoStore
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                Text("Email")
                    .padding(.top, 1)
                
                TextField("Enter Email", text: $email)
                    .textInputAutocapitalization(.never) // 대문자 방지
                    .disableAutocorrection(true) // 자동수정 방지
                    .keyboardType(.emailAddress) // 이메일용 키보드
                    .frame(height: 40)
                    .padding(.top, -8.5)
                    .padding(.bottom, 17)
                
                Text("Password")
                
                SecureField("Enter Password", text: $password)
                    .textInputAutocapitalization(.never)
                    .frame(height: 40)
                    .padding(.top, -8.5)
            }
            .padding()
            .textFieldStyle(.roundedBorder)
            Button {
                Task {
//                    await userInfoStore.fetchUser(user: userInfoStore.user)
                    await userInfoStore.checkVerificationEmail(emailAddress: email, password: password)
                    if Auth.auth().currentUser?.isEmailVerified ?? false {
                        await userInfoStore.logIn(emailAddress: email, password: password)
//                        isShowingSuccessAlert.toggle()
                        print("true")
                        dismiss()
                    } else {
                        loginFailActive.toggle()
//                        userInfoStore.isShowingFailAlert.toggle()
                        userInfoStore.sendVerificationEmail()
                        print("아직 false")
                    }
                }
            } label: {
                Text("Sign In")
                    .frame(width: 360, height: 46)
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(7)
            }
            .disabled(email.isEmpty || password.isEmpty )
            .padding(.top, 10)
//            .alert("Log In", isPresented: $isShowingAlert) {
//                Button("OK"){}
//            } message: {
//                Text("로그인 버튼 눌렀을 때")
//            }
            .alert("log in", isPresented: $loginFailActive) {
                Button("OK"){
                }
            } message: {
                Text("인증되지 않은 이메일입니다. 받은 메일을 확인하여 인증해 주세요.")
            }
            Spacer()
        }
        .background(Color.white) // background 컬러 지정안해주면 화면 밖 눌러도 키보드 안내려감.
        .onTapGesture() {
            endEditing()
        }
        .frame(maxHeight: .infinity)
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
extension View {
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
