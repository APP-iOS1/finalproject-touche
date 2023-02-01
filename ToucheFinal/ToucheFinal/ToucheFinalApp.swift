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
//            UserDefaults.standard.set(true, forKey: "isShowingOnboardingView")
        }
    @StateObject var userInfoStore: UserInfoStore = UserInfoStore()
    @StateObject var perfumeStore = PerfumeStore()
    
    let colorPalette = ColorPalette()
    
    var body: some Scene {
        WindowGroup {
            //            TESTVIEWTS()
            PerfumeTabView()
                .environmentObject(colorPalette)
                .environmentObject(perfumeStore)
                .environmentObject(userInfoStore)
        }
    }
}
