//
//  LogInView.swift
//  ToucheFinal
//
//  Created by MIJU on 2023/01/18.
//

import SwiftUI

struct LogInView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var isShowingAlert: Bool = false
    @Binding var user: Bool
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                    Text("Email")
                    .padding(.top, 1)
                
                    TextField("Enter email", text: $email)
                        .textInputAutocapitalization(.never)
                        .frame(height: 40)
                        .padding(.top, -8.5)
                        .padding(.bottom, 17)
                
                    Text("Password")
                
                    SecureField("Enter password", text: $password)
                        .textInputAutocapitalization(.never)
                        .frame(height: 40)
                        .padding(.top, -8.5)
            }
            .padding()
            .textFieldStyle(.roundedBorder)
            
            Button {
                user = true
                UserDefaults.standard.set(self.user, forKey: "user")
                dismiss()
            } label: {
                Text("Sign In")
                    .frame(width: 360, height: 46)
                    .background(.black)
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
        
        
    }
    
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView(user: .constant(true))
    }
}
