//
//  ContactUsView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/02/13.
//

import SwiftUI

struct ContactUsView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userInfoStore: UserInfoStore
    
    private let pasteboard = UIPasteboard.general
    @State private var buttonText: String = "Copy"
    @State private var email: String = "contactus@touche.com"
    
    var body: some View {
        NavigationView{
            ScrollView{
            VStack{
                Image("touche2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 50)
                Spacer()
                VStack(alignment: .leading){
                    Text("Team Touché")
                        .font(.system(size: 20))
                    Divider()
                        .frame(width: 200)
                    HStack{
                        Image(systemName: "envelope")
                        Text("contactus@touche.com")
                            .tint(.black)
                        Button{
                            copyToClipboard()
                        } label: {
                            Text(buttonText)
                                .tint(.black)
                        }
                        
                    }
                    
                }
                Spacer()
            }
        }
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
