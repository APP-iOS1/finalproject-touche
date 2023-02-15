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
    @EnvironmentObject var userInfoStore: UserInfoStore
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State private var showingAlert: Bool = false
    
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    let bundleID = Bundle.main.bundleIdentifier
    
    @State var showContactUsView: Bool = false
    @State var showPrivacyPolicyView: Bool = false
    @State var showTermsandConditionsView: Bool = false
    @State var showVersionView: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                List{
                    /// SETTINGS Group
                    Group {
                        Text("SETTINGS")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                        Button{
                            Task{
                                if let url = URL(string: "app-settings:\(bundleID!)") {
                                    await UIApplication.shared.open(url)
                                }
                            }
                        } label :{
                            HStack{
                                Text("Notification")
                                Spacer()
                                Image(systemName: "arrow.up.right")
                            }
                        }
                        if !(userInfoStore.userInfo == nil){
                            Button{
                                showDeleteAccountView.toggle()
                            } label :{
                                HStack{
                                    Text("Delete Account")
                                    Spacer()
                                    //Image(systemName: "arrow.up.right")
                                }
                            }.fullScreenCover(isPresented: $showDeleteAccountView){
                                DeleteAccountView()
                            }
                        }
                        Group{
                            Text("SUPPORT")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .padding(.top,50)
                            Button("Contact Us"){
                                showContactUsView.toggle()
                            }
                            .fullScreenCover(isPresented: $showContactUsView){
                                ContactUsView()
                            }
                            Button("Privacy Policy"){
                                showPrivacyPolicyView.toggle()
                            }
                            .fullScreenCover(isPresented: $showPrivacyPolicyView){
                                PrivacyView()
                            }
                            Button("Terms & Conditions"){
                                showTermsandConditionsView.toggle()
                            }
                            .fullScreenCover(isPresented: $showTermsandConditionsView){
                                TermsandConditionsView()
                            }
                            Button("Version"){
                                showVersionView.toggle()
                            }
                            .fullScreenCover(isPresented: $showVersionView){
                                VersionView()
                            }
                        }
                    }
                } // List 종료
                .listStyle(.plain)
                .scrollDisabled(true)
                .frame(maxHeight: 400)
                VStack{
                    if !(userInfoStore.userInfo == nil){
                        Button{
                            userInfoStore.logOut()
                        } label: {
                            Text("Sign Out")
                                .frame(width: 150, height: 40.0)
                                .background(.black)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                    }
                }
                .padding(.leading, 20)
                Spacer()
            }// VStack 종료
            Spacer()
        } // NavigationView 종료
        
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    self.mode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
                .foregroundColor(.black)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .environmentObject(UserInfoStore())
    }
}
