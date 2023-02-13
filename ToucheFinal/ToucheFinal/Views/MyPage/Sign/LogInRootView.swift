//
//  LogInRootView.swift
//  ToucheFinal
//
//  Created by MIJU on 2023/01/18.
//

import SwiftUI
import AlertToast
import FirebaseAuth

struct LogInRootView: View {
    @EnvironmentObject var userInfoStore: UserInfoStore
    
    var body: some View {
        VStack {
            if Auth.auth().currentUser?.isEmailVerified ?? false {
                MyPageView(perfume: dummy[0], comment: commentDummy[0]) // 로그인 되면
            } else { // 로그인 안되면
                SignOutView()
    //            MyPageView()
            }
        }
        /// 없는 정보로 로그인 할때 경고창
        .toast(isPresenting: $userInfoStore.isShowingFailAlert) {
            AlertToast(displayMode: .hud, type: .error(Color.red), title: "Incorrect Information!", subTitle: "Please check email or password", style: .style(titleColor: Color.red, subTitleColor: Color.black))
        }
        
        /// 로그인 성공시 알럿
        .toast(isPresenting: $userInfoStore.isShowingSuccessAlert) {
            AlertToast(displayMode: .hud, type: .complete(Color.green), title: "Welcome to Touché !", subTitle: "Sign in Success", style: .style(titleColor: Color.blue))
        }
        
        /// 로그 아웃 성공시 알럿
        .toast(isPresenting: $userInfoStore.isShowingSignoutAlert){
            AlertToast(displayMode: .hud, type: .complete(Color.green), title: "sign out complete.", subTitle: "See you again!", style: .style(titleColor: Color.blue, subTitleColor: Color.black))
        }
    }
}

struct LogInRootView_Previews: PreviewProvider {
    static var previews: some View {
        LogInRootView()
            .environmentObject(UserInfoStore())
    }
}
