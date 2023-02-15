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
    
    var body: some View {
        
        NavigationView {
            
                VStack(alignment: .leading){
                    List{
                        Text("SETTINGS")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                        
                        Button{
                            Task{
                                if let url = URL(string: "app-settings:\(bundleID!)") {
                                    
                                    await UIApplication.shared.open(url)
//                                  
                                    
                                }
                            }
                        } label :{
                            HStack{
                                Text("Notification")
                                Spacer()
                                Image(systemName: "arrow.up.right")
                            }
                        }
                        
                        
                        

                        
                        Button {
                            showSelectNationView.toggle()
                        } label: {
                            HStack{
                                Text("Country / Region")
                                Spacer()
                                //Image(systemName: "chevron.right")
                            }
                        }
                        .fullScreenCover(isPresented: $showSelectNationView) {
                            SelectNationView()
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
            
                        }
                    }
                    .listStyle(.plain)
                    .scrollDisabled(true)
                    VStack{
                        
                        if userInfoStore.user?.isEmailVerified ?? false {
                        Button{
                            Task {
                                await userInfoStore.logOut()
                                userInfoStore.isShowingSignoutAlert.toggle()
                            }
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
                    Spacer(minLength: 110)
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
    }
}
