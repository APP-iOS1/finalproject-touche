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
    @State var showAcknowledgementsView: Bool = false
    
    var body: some View {
        NavigationView {
                ScrollView {
                    List{
                        /// SETTINGS Group
                        Group {
                            Text("SETTINGS")
                                .font(.headline)
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
                            
                            if userInfoStore.user?.isEmailVerified ?? false {
                                
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
                        }
                        Group{
                            Text("SUPPORT")
                                .font(.headline)
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
                        }
                        Group{
                            Text("ABOUT")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .padding(.top,50)
                            
                            
                            Button("Acknowledgements"){
                                showAcknowledgementsView.toggle()
                            }
                            .fullScreenCover(isPresented: $showAcknowledgementsView){
                                AcknowledgementsView()
                            }
                            
                            Button("Version"){
                                showVersionView.toggle()
                            }
                            .fullScreenCover(isPresented: $showVersionView){
                                VersionView()
                            }
                        }
                        
                    }
                    .listStyle(.plain)
                    .frame(height: 600)
                    Spacer()
                    
                    HStack{
                        if userInfoStore.user?.isEmailVerified ?? false {
                            Spacer()
                            Button{
                                Task {
                                    await userInfoStore.logOut()
                                    userInfoStore.isShowingSignoutAlert.toggle()
                                }
                            } label: {
                                Text("Sign Out")
                                    .frame(width: UIScreen.main.bounds.width - 30, height: 46.0)
                                    .background(.black)
                                    .foregroundColor(.white)
                                    .cornerRadius(7)
                            }
                            Spacer()
                        }
                    }
                    .padding(.bottom, 20)
                }// VStack 종료
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
