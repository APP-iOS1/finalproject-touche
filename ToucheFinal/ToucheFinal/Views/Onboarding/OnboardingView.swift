//
//  OnboardingView.swift
//  ToucheFinal
//
//  Created by 조석진 on 2023/01/31.
//

import SwiftUI

struct OnboardingView: UIViewControllerRepresentable {
    @Binding var isShowingOnboardingView: Bool
    
    func makeUIViewController(context: Context) -> MagneticViewcontroller {
        let viewController = UIStoryboard(name: "Main", bundle: nil)
      .instantiateViewController(withIdentifier: "MagneticViewcontroller")
      as! MagneticViewcontroller
        viewController.tabBtn = {
            isShowingOnboardingView = false
        }
        return viewController
    }

    func updateUIViewController(_ uiViewController: MagneticViewcontroller, context: Context) {}
}
