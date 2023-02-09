//
//  Modifier.swift
//  ToucheFinal
//
//  Created by TAEHYOUNG KIM on 2023/02/02.
//

import SwiftUI
import AlertToast

struct SignInFullCover: ViewModifier {
    @EnvironmentObject var userInfoStore: UserInfoStore
    @Binding var isShowing: Bool
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isShowing, content: {
                NavigationStack{
                    LogInSignUpView(backButtonMark: "xmark")
                }
                // 성공 알림
                .toast(isPresenting: $userInfoStore.isShowingSuccessAlert){
                    AlertToast(displayMode: .hud, type: .complete(Color.green), title: "Welcome to Touché !", subTitle: "Sign in Success", style: .style(titleColor: Color.blue))
                }
                // 실패 알림
                .toast(isPresenting: $userInfoStore.isShowingFailAlert){
                    AlertToast(displayMode: .hud, type: .error(Color.red), title: "Incorrect Information", subTitle: "Please check email or password", style: .style(titleColor: Color.red, subTitleColor: Color.black))
                }
            })

    }
}
//
//struct Modifier_Previews: PreviewProvider {
//    static var previews: some View {
//        Modifier()
//    }
//}
