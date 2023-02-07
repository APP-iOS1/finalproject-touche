//
//  LogInRootView.swift
//  ToucheFinal
//
//  Created by MIJU on 2023/01/18.
//

import SwiftUI

struct LogInRootView: View {
    @EnvironmentObject var userInfoStore: UserInfoStore
    var body: some View {
        if userInfoStore.userInfo != nil {
            MyPageView(perfume: dummy[0], comment: commentDummy[0]) // 로그인 되면
        } else { // 로그인 안되면
            SignOutView()
//            MyPageView()
        }
    }
}

struct LogInRootView_Previews: PreviewProvider {
    static var previews: some View {
        LogInRootView()
            .environmentObject(UserInfoStore())
    }
}
