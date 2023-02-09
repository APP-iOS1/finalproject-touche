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
    @State private var isShowingAlert4 = false
    
    var body: some View {
        VStack {
            Button {
                isShowingAlert.toggle()
            } label: {
                Text("성공")
                    .frame(width: 360, height: 46)
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(7)
            }
            
            Button {
                isShowingAlert2.toggle()
            } label: {
                Text("실패")
                    .frame(width: 360, height: 46)
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(7)
            }
            
            Button {
                isShowingAlert3.toggle()
            } label: {
                Text("로딩")
                    .frame(width: 360, height: 46)
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(7)
            }
            
            Button {
                isShowingAlert4.toggle()
            } label: {
                Text("로그아웃")
                    .frame(width: 360, height: 46)
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(7)
            }
        }
        .toast(isPresenting: $isShowingAlert){
            AlertToast(displayMode: .hud, type: .complete(Color.green), title: "Welcome to Touché !", subTitle: "Sign in Success", style: .style(titleColor: Color.blue))
        }
        
        .toast(isPresenting: $isShowingAlert2){
            AlertToast(displayMode: .hud, type: .error(Color.red), title: "Incorrect Information", subTitle: "Please check email or password", style: .style(titleColor: Color.red, subTitleColor: Color.black))
        }
        
        .toast(isPresenting: $isShowingAlert3, duration: 2, tapToDismiss: true){
            AlertToast(displayMode: .hud, type: .loading, title: "Loading")
        }
        
        .toast(isPresenting: $isShowingAlert4){
            AlertToast(displayMode: .hud, type: .complete(Color.green), title: "sign out complete.", subTitle: "See you again!", style: .style(titleColor: Color.blue, subTitleColor: Color.black))
        }
    }
}

struct TESTALERTVIEW_Previews: PreviewProvider {
    static var previews: some View {
        TESTALERTVIEW()
    }
}
