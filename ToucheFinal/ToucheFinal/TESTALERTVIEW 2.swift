//
//  TESTALERTVIEW.swift
//  ToucheFinal
//
//  Created by 김태성 on 2023/02/08.
//

import SwiftUI
import AlertToast

struct TESTALERTVIEW: View {
    @State private var isShowingAlert = false
    @State private var isShowingAlert2 = false
    @State private var isShowingAlert3 = false
    
    var body: some View {
        VStack {
            Button {
                isShowingAlert.toggle()
            } label: {
                Text("Sign In")
                    .frame(width: 360, height: 46)
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(7)
            }
            
            Button {
                isShowingAlert2.toggle()
            } label: {
                Text("Sign In")
                    .frame(width: 360, height: 46)
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(7)
            }
            
            Button {
                isShowingAlert3.toggle()
            } label: {
                Text("Sign In")
                    .frame(width: 360, height: 46)
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(7)
            }
        }
        .toast(isPresenting: $isShowingAlert){
            AlertToast(displayMode: .hud, type: .complete(Color.green), title: "Sign in Success")
        }
        
        .toast(isPresenting: $isShowingAlert2){
            AlertToast(displayMode: .hud, type: .error(Color.red), title: "Incorrect Information")
        }
        
        .toast(isPresenting: $isShowingAlert3, duration: 2, tapToDismiss: true){
            AlertToast(displayMode: .hud, type: .loading, title: "Loading")
        }
    }
}

struct TESTALERTVIEW_Previews: PreviewProvider {
    static var previews: some View {
        TESTALERTVIEW()
    }
}
