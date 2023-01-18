//
//  SettingView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/18.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        NavigationStack{
            List{
                
                Text("SETTINGS")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                
                NavigationLink{
                    // 알림 설정
                } label :{
                    Text("Notification")
                }
                
                NavigationLink{
                    // GPS 설정
                } label :{
                    Text("Location Service")
                }
                
                NavigationLink{
                    // 국가 선택 (Localization)
                } label: {
                    Text("Country / Region - (내가 선택한 국가)")
                }
                
                NavigationLink{
                    // 회원 탈퇴
                } label :{
                    Text("Delete Account")
                }
                
                Text("SUPPORT")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.top,50)
                Text("Contact US")
                Text("Help and Inforamtion")
                Text("Privacy Policy")
                Text("Terms & Conditions")
                
            }
            .listStyle(.plain)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
