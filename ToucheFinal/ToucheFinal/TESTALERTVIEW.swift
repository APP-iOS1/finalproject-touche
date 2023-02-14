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
    @State private var brandPopupActive = false
    @State private var isShowingAlert5 = false
    
    var body: some View {
        ScrollView {
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
            
            Button {
                brandPopupActive.toggle()
            } label: {
                Text("모든알람테스트")
                    .frame(width: 360, height: 46)
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(7)
            }
            
            Button {
                isShowingAlert5.toggle()
            } label: {
                Text("댓글 남기기")
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
            AlertToast(displayMode: .hud, type: .complete(Color.green), title: "Sign out complete.", subTitle: "See you again!", style: .style(titleColor: Color.blue, subTitleColor: Color.black))
        }
        
        //MARK: 필터링 개수제한 팝업
        .toast(isPresenting: $brandPopupActive) {
            AlertToast(displayMode: .alert, type: .systemImage("xmark", Color.black), title: "Notice", subTitle: "You can select up to 10 brands.")
        }
        
        .toast(isPresenting: $brandPopupActive) {
            AlertToast(displayMode: .hud, type: .systemImage("xmark", Color.black), title: "Notice", subTitle: "You can select up to 10 brands.")
        }
        
        .toast(isPresenting: $brandPopupActive) {
            AlertToast(displayMode: .banner(.pop), type: .systemImage("xmark", Color.black), title: "Notice", subTitle: "You can select up to 10 brands.")
        }
        
        .toast(isPresenting: $isShowingAlert5){
            AlertToast(displayMode: .alert, type: .complete(Color.green), title: "", subTitle: "Thank you for the comments.", style: .style(titleColor: Color.blue))
        }
    }
}

struct TESTALERTVIEW_Previews: PreviewProvider {
    static var previews: some View {
        TESTALERTVIEW()
    }
}
