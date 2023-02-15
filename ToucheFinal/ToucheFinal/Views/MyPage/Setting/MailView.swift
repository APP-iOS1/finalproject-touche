//
//  MailView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/02/16.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setToRecipients(["yujin0552@naver.com"])
        mail.setMessageBody("Team Touche", isHTML: false)
        
        present(mail, animated: true, completion: nil)
        
    }
    
    @IBAction func buttonClicked(_ sender: Any){
        sendEmail(recipient: ["yujin0552@naver.com"], text: "Team Touche")
    }
    
    
    func sendEmail(recipient: [String], text: String){
        if MFMailComposeViewController.canSendMail()
        {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(recipient)
            mail.setMessageBody(text, isHTML: false)
            
            present(mail, animated: true, completion: nil)
        }
        else {
            
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?){
        controller.dismiss(animated: true, completion: nil)
    }
    
}
