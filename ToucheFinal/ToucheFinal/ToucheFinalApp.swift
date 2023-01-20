//
//  ToucheFinalApp.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/17.
//

import SwiftUI
import FirebaseCore


@main
struct ToucheFinalApp: App {
    
    init() {
            FirebaseApp.configure()
        }
    
    var body: some Scene {
        let userInfoStore: UserInfoStore = UserInfoStore()
        WindowGroup {
            PerfumeTabView()
                .environmentObject(userInfoStore)
        }
    }
}
