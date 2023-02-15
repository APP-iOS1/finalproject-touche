//
//  MailView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/02/16.
//

import SwiftUI
import MessageUI
import Foundation

struct MailView: View {

    class MailComposeViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
        static let shared = MailComposeViewController()
    
        func sendEmail() {
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients(["yujin0552@naver.com"])

                UIApplication.shared.windows.last?.rootViewController?.present(mail, animated: true, completion: nil)
            } else {
                // Alert
            }
        }
    
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true, completion: nil)
        }
    }
    
    var body: some View {
        Button(action: {
            MailComposeViewController.shared.sendEmail()
        }, label: {
            Text("Send")
        })
    }
}

struct MailView_Previews: PreviewProvider {
    static var previews: some View {
        MailView()
    }
}
