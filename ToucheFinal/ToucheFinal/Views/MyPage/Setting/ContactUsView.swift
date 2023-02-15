//
//  ContactUsView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/02/13.
//

import UIKit
import SwiftUI
import MessageUI

struct ContactUsView: View {

    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userInfoStore: UserInfoStore
    
    private let pasteboard = UIPasteboard.general
    @State private var buttonText: String = "Copy"
    @State private var email: String = "contactus@touche.com"
    
    var body: some View {
        
        NavigationView{
            ScrollView{
                VStack(alignment: .leading){
                Image("touche2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 50)
                Divider()
                    .frame(width: 200)
            
                VStack(alignment: .leading){
                    // 클릭 시 
                    Button("Send mail to Team Touché"){
                      // @IBAction func buttonClicked
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 46)
                    .background(.gray)
                    .cornerRadius(7)
                    .padding(.bottom, 15)
                    
                    
                    Button("Copy Team Touché's Mail"){
                        copyToClipboard()
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 46)
                    .background(.gray)
                    .cornerRadius(7)
                }
                .tint(.black)
                Spacer()
            }
        }
            .scrollDisabled(true)
            .navigationBarTitle("Contact Us", displayMode: .inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color.black)
                    }
                }
            }
        }
    }
    func copyToClipboard() {
        pasteboard.string = self.email
        self.buttonText = "Copied"
    }
}






struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView()
    }
}


