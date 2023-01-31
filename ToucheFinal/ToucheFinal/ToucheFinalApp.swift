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
            UserDefaults.standard.set(true, forKey: "isShowingOnboardingView")
        }
    @StateObject var userInfoStore: UserInfoStore = UserInfoStore()
    @StateObject var perfumeStore = PerfumeStore()
    
    var body: some Scene {
        WindowGroup {
            PerfumeTabView()
//            TestView()
                .environmentObject(perfumeStore)
                .environmentObject(userInfoStore)
        }
    }
}
