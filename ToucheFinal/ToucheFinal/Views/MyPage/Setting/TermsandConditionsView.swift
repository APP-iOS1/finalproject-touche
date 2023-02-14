//
//  TermsandConditionsView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/02/13.
//

import SwiftUI

struct TermsandConditionsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    Image("touche2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 50)
                    VStack(alignment: .leading){
                        Text("Touché Terms & Conditions")
                            .fontWeight(.semibold)
                            .font(.system(size: 19))
                            .padding(.bottom, 7)
                        
                        Group{
                            Text("Chapter 1 General Provisions")
                                .modifier(Title())
                            
                            Text("This is a guide to help you understand the terms and conditions of use as a whole, including the purpose of this terms and conditions of use.")
                            
                            Text("Article 1 (Purpose)")
                                .modifier(Title())
                            
                            Text("These Terms of Use (hereinafter referred to as 'Terms of Use') are intended to stipulate the conditions, procedures and requirements for the 'Perfume Information Provision and Community Service' (hereinafter referred to as 'Service') provided by Team Touché.")
                            
                            Text("Article 2 (Notices and Effectiveness)")
                                .modifier(Title())
                            
                            Text("The Touché team notifies the user of the contents of this Terms and Conditions by the application screen or homepage (hereinafter referred to as “application screen, etc.”)")
                            
                            Text("The Touché Team takes steps to enable you to ask and answer questions regarding the contents of this Terms and Conditions.")
                            
                            Text("The Touché team may revise this Terms and Conditions to the extent that it does not violate the relevant Acts, such as the 「Act on Promotion of Information and Communications Network Utilization and Information Protection」, etc.")
                            
                            Text("Agreement of this Terms and Conditions means that you agree to visit the Service regularly to check any changes made to this Terms and Conditions. The  Touché team is not responsible for any damage caused by users who do not know the changed Terms and Conditions.")
                            
                            Text("When the Touché team revises this Terms and Conditions, the Touché team clearly notifies the existing Terms of Conditions, revised Terms of Conditions, application date of the revised Terms and Conditions and the reason for revision for a considerable period from 7 days before the application date by the method referred to in Paragraph 1. And when the revised contents are important to the user, the Touché team clearly notifies them for a considerable period from 30 days before the application date by the method referred to in Paragraph 1.")
                        }
                        .padding(.bottom, 7)
                        
                        Group{
                            Text("Article 3 (Definition of terms)")
                                .modifier(Title())
                            Text("The terms used in this Terms and Conditions are defined as follows.")
                            Text("a) Service: All Services provided by the Touché team, which are available to users by all feasible devices such as PCs, smartphones, tablets, etc.")
                            Text("b) User: All customers using this Service")
                            Text("c) E-mail address: An e-mail address decided by the user for identification of the user and the Service use, consisting of a combination of letters and numbers approved by the Touché team.")
                            Text("d) Passphrase: A combination of letters and numbers determined by the user to ensure that the user is consistent with the user’s email address and to protect confidentiality.")
                            
                        }
                        .padding(.bottom, 7)
                        
                        Group{
                            Text("Chapter 2 Service Contract")
                                .modifier(Title())
                            Text("This is a guide to help you understand the situations that may occur when the Service contract is concluded.")
                            Text("Article 4 (Establishment of Service Contract)")
                                .modifier(Title())
                            Text("The Service contract is concluded when the user agrees to this Terms and Conditions and applies for Service use after completing the entered matter, and the Touché team approves the application.")
                        }
                        .padding(.bottom, 7)
                        
                    }
                    .padding()
                }
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
    }
}

struct TermsandConditionsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsandConditionsView()
    }
}


struct Title: ViewModifier{
    func body(content: Content) -> some View {
        content
            .fontWeight(.semibold)
            .font(.system(size: 17))
            .padding(.bottom, 4)
    }
}
