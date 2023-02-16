//
//  ContactUsView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/02/13.
//

import UIKit
import SwiftUI
import MessageUI
import AlertToast

struct ContactUsView: View {

    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userInfoStore: UserInfoStore
    
    private let pasteboard = UIPasteboard.general
    @State private var buttonText: String = "Copy"
    @State private var email: String = "contactus@touche.com"
    @State private var isCopied: Bool = false
    
    var body: some View {
        
        NavigationView{
            ScrollView{
                VStack{
                Image("touche2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 50)
                Divider()
                    .frame(width: 200)
            
                VStack(alignment: .leading){
                    // 클릭 시
                    
                    Button("Send mail to Team Touché"){
                        DispatchQueue.main.async {
                            MailComposeViewController.shared.sendEmail()
                        }
                        
                    }
                    .frame(width: UIScreen.main.bounds.width - 30, height: 46.0)
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(7)
                    .padding(.top, 18)
                    .padding(.bottom, 18)
                    
                    Button("Copy Team Touché's mail"){
                        isCopied.toggle()
                        copyToClipboard()
                    }
                    .frame(width: UIScreen.main.bounds.width - 30, height: 46.0)
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(7)
                    .toast(isPresenting: $isCopied){
                        AlertToast(displayMode: .hud, type: .complete(Color.red), title: "Copied Success!", subTitle: "Paste it where you want.", style: .style(titleColor: Color.green, subTitleColor: Color.black))
                    }
                    
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
    
    class MailComposeViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
        static let shared = MailComposeViewController()
    
        func sendEmail() {
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients(["test@test.com"])

                UIApplication.shared.windows.last?.rootViewController?.present(mail, animated: true, completion: nil)
            } else {
                // Alert
            }
        }
    
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true, completion: nil)
        }
    }
    
}






struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView()
    }
}


