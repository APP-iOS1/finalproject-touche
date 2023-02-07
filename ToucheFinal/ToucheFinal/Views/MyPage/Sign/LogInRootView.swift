//
//  LogInRootView.swift
//  ToucheFinal
//
//  Created by MIJU on 2023/01/18.
//

import SwiftUI
import AlertToast

struct LogInRootView: View {
    @EnvironmentObject var userInfoStore: UserInfoStore
    var body: some View {
        VStack {
            if userInfoStore.userInfo != nil {
                MyPageView(perfume: dummy[0], comment: commentDummy[0]) // 로그인 되면
            } else { // 로그인 안되면
                SignOutView()
    //            MyPageView()
            }
        }
        /// 없는 정보로 로그인 할때 경고창
        .toast(isPresenting: $userInfoStore.isShowingFailAlert) {
            AlertToast(displayMode: .hud, type: .error(Color.red), title: "Incorrect Information!")
        }
    }
}

struct LogInRootView_Previews: PreviewProvider {
    static var previews: some View {
        LogInRootView()
            .environmentObject(UserInfoStore())
    }
}
