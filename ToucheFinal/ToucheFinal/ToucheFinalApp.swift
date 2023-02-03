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
            PerfumeStore.shared.read()
            UserDefaults.standard.set(true, forKey: "isShowingOnboardingView")
        }
    @StateObject var userInfoStore: UserInfoStore = UserInfoStore()
    
    let colorPalette = ColorPalette()
    
    var body: some Scene {
        WindowGroup {
            PerfumeTabView()
                .environmentObject(colorPalette)
                .environmentObject(userInfoStore)
        }
    }
}
