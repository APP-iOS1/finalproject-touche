//
//  SettingView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/18.
//

import SwiftUI

struct SettingView: View {
    
    @State var showSelectNationView: Bool = false
    @State var showDeleteAccountView: Bool = false
    
    var body: some View {
        
        NavigationStack{
            
            List{
                Text("SETTINGS")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                
                Button{
                    Task{
                        if let url = URL(string: UIApplication.openNotificationSettingsURLString) {
                       
                            await UIApplication.shared.open(url)
                        }
                    }
                } label :{
                    HStack{
                        Text("Notification")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                }
        
                
                
                Button{
                    // GPS 설정
                } label :{
                    HStack{
                        Text("Location Service")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                }
                
                Button {
                    showSelectNationView.toggle()
                } label: {
                    HStack{
                        Text("Country / Region - (내가 선택한 국가)")
                        Spacer()
                        Image(systemName: "arrow.up.right")
                    }
                }
                .fullScreenCover(isPresented: $showSelectNationView) {
                    SelectNationView()
                }
                
                
                Button{
                    showDeleteAccountView.toggle()
                } label :{
                    HStack{
                        Text("Delete Account")
                        Spacer()
                        Image(systemName: "arrow.up.right")
                    }
                }.fullScreenCover(isPresented: $showDeleteAccountView){
                    DeleteAccountView()
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
