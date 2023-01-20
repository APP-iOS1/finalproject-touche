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
        if userInfoStore.user != nil {
            MyPageView() // 로그인 되면
        } else { // 로그인 안되면
            SignOutView()
        }
    }
}

struct LogInRootView_Previews: PreviewProvider {
    static var previews: some View {
        LogInRootView()
    }
}
