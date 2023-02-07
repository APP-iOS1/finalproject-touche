//
//  TESTPOPUPVIEW.swift
//  ToucheFinal
//
//  Created by 김태성 on 2023/02/07.
//

import SwiftUI
import PopupView

struct TESTPOPUPVIEW: View {
    @State private var isShowingPopup = false
    @State private var isShowingPopup2 = false
    
    var body: some View {
        VStack {
            Button {
                isShowingPopup.toggle()
            } label: {
                Text("Sign In")
                    .frame(width: 360, height: 46)
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(7)
            }
            
            Button {
                isShowingPopup2.toggle()
            } label: {
                Text("Sign In")
                    .frame(width: 360, height: 46)
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(7)
            }
        }
        .popup(isPresented: $isShowingPopup) {
            Text("Incorrect information!")
                .bold()
                .frame(width: UIScreen.main.bounds.width - 20, height: 50)
                .background(Color.red.opacity(0.7))
                .cornerRadius(20.0)
        } customize: {
            $0.autohideIn(2)
                .type(.floater())
                .position(.top)
                .animation(.spring())
                .isOpaque(true)
                .closeOnTapOutside(true)
                .backgroundColor(.black.opacity(0.07))
        }
        
        .popup(isPresented: $isShowingPopup2) {
            Text("success!")
                .bold()
                .frame(width: UIScreen.main.bounds.width - 20, height: 50)
                .background(Color.green.opacity(0.7))
                .cornerRadius(20.0)
        } customize: {
            $0.autohideIn(2)
                .type(.floater())
                .position(.top)
                .animation(.spring())
                .isOpaque(true)
                .closeOnTapOutside(true)
//                .backgroundColor(.black.opacity(0.1))
        }
    }
}

struct TESTPOPUPVIEW_Previews: PreviewProvider {
    static var previews: some View {
        TESTPOPUPVIEW()
    }
}
