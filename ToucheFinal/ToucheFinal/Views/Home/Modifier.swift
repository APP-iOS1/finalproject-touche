//
//  Modifier.swift
//  ToucheFinal
//
//  Created by TAEHYOUNG KIM on 2023/02/02.
//

import SwiftUI

struct SignInFullCover: ViewModifier {
    @Binding var isShowing: Bool
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isShowing, content: {
                NavigationStack{
                    LogInSignUpView(backButtonMark: "xmark")
                }
            })

    }
}
//
//struct Modifier_Previews: PreviewProvider {
//    static var previews: some View {
//        Modifier()
//    }
//}
