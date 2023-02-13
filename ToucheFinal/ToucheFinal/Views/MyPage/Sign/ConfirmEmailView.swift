//
//  ConfirmEmailView.swift
//  ToucheFinal
//
//  Created by MIJU on 2023/02/13.
//

import SwiftUI

struct ConfirmEmailView: View {
    @EnvironmentObject var userInfoStore: UserInfoStore
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button {
            userInfoStore.sendVerificationEmail()
        } label: {
            Text("이메일 인증")
                .frame(width: 360, height: 46)
                .background(.black)
                .foregroundColor(.white)
                .cornerRadius(7)
        }

    }
//    func sendVerificationEmail() {
//        userInfoStore.user?.sendEmailVerification()
//        print(userInfoStore.user?.isEmailVerified)
//        print(userInfoStore.user?.email)
//        print("전송완료")
//    }
}

struct ConfirmEmailView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmEmailView()
    }
}
