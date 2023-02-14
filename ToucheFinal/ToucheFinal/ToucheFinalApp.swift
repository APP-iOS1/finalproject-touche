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
    
    var body: some Scene {
        let userInfoStore = UserInfoStore()
        let perfumeStore = PerfumeStore()
        let colorPalette = ColorPalette()
        let commentStore = CommentStore()
        let filterStore = FilterViewModel()
        WindowGroup {
            PerfumeTabView()
                .environmentObject(colorPalette)
                .environmentObject(userInfoStore)
                .environmentObject(perfumeStore)
                .environmentObject(commentStore)
                .environmentObject(filterStore)
        }
    }
}
