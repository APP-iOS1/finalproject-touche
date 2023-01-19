//
//  LogInRootView.swift
//  ToucheFinal
//
//  Created by MIJU on 2023/01/18.
//

import SwiftUI

struct LogInRootView: View {
    @State private var user: Bool = UserDefaults.standard.bool(forKey: "user")
    var body: some View {
        if user {
            MyPageView() // 로그인 되면
        } else { // 로그인 안되면
            SignOutView(user: $user)
        }
    }
}

struct LogInRootView_Previews: PreviewProvider {
    static var previews: some View {
        LogInRootView()
    }
}
