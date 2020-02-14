//
//  RegistrationViewController.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 2/13/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//

import UIKit
import MessageUI

class RegistrationViewController: UIViewController {
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func preRegisterBtn(_ sender: UIButton) {
        let usersFullName = nameTxt.text ?? "No name given"
        let usersEmail = emailTxt.text ?? "No email given"
        showMailComposer(usersFN: usersFullName, usersPrefEmail: usersEmail)
    }
    func showMailComposer(usersFN: String, usersPrefEmail: String){
            guard MFMailComposeViewController.canSendMail() else {
                print("Email is not supported on this device")
                return
            }
            let composer =  MFMailComposeViewController()
            composer.mailComposeDelegate = self
            composer.setToRecipients(["Chris.csrstaff@gmail.com"])
            composer.setSubject("\(usersFN)'s Pre-registation request")
            composer.setMessageBody("It works! See See. My prefered email is \(usersPrefEmail)", isHTML: false)
            present(composer, animated: true)
        }
    
    

}
extension RegistrationViewController: MFMailComposeViewControllerDelegate , UITextFieldDelegate{
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            controller.dismiss(animated: true)
        }
            switch result {
            case .cancelled:
                print("Cancelled")
            case .failed:
                print("Failed to send")
            case .saved:
                print("Saved")
                case .sent:
                print("Sent!")
            default:
                print("Not accounted for")
            }
            controller.dismiss(animated: true, completion: nil)
        }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTxt.resignFirstResponder()
        emailTxt.resignFirstResponder()
        return true
    }
    
    }

