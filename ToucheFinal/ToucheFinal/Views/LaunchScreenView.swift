//
//  LaunchScreenView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/02/15.
//

import SwiftUI

struct LaunchScreenView: View {
    @State private var isActive = false
    @Binding var isShowingOnboardingView: Bool
    
    var body: some View {
        if isActive {
            OnboardingView(isShowingOnboardingView: $isShowingOnboardingView)
        } else {
            ZStack {
//                Color("logoColor")
//                    .ignoresSafeArea()
                Image("AppIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    self.isActive = true
                }
            }
        }
    }
}

//struct LaunchScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        LaunchScreenView()
//    }
//}
