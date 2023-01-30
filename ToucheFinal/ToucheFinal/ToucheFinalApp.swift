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
    @StateObject var userInfoStore: UserInfoStore = UserInfoStore()
    
    @StateObject var perfumeStore = PerfumeStore()
    
    var body: some Scene {
        WindowGroup {
//            PerfumeTabView()
            MyPageView(perfume: dummy[0], comment: commentDummy[0])
//            TestView()
                .environmentObject(perfumeStore)
                .environmentObject(userInfoStore)
        }
    }
}
