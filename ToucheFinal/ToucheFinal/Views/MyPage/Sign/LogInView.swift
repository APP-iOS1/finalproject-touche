//
//  LogInView.swift
//  ToucheFinal
//
//  Created by MIJU on 2023/01/18.
//

import SwiftUI
import AlertToast

struct LogInView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var isShowingAlert: Bool = false
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
                    await userInfoStore.logIn(emailAddress: email, password: password)
                    
                    if userInfoStore.loginState == .success {
//                        isShowingSuccessAlert.toggle()
                        dismiss()
                    } else {
                        userInfoStore.isShowingFailAlert.toggle()
                    }
                }
            } label: {
                Text("Sign In")
                    .frame(width: 360, height: 46)
                    .background(email.isEmpty || password.isEmpty ? .gray : .black)
                    .foregroundColor(.white)
                    .cornerRadius(7)
            }
            .disabled(email.isEmpty || password.isEmpty )
            .padding(.top, 10)
            .alert("Log In", isPresented: $isShowingAlert) {
                Button("OK"){}
            } message: {
                Text("로그인 버튼 눌렀을 때")
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
