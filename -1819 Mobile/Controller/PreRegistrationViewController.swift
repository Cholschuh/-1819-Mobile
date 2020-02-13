//
//  PreRegistrationViewController.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 2/13/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//

import UIKit
import MessageUI

class PreRegistrationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    
    @IBAction func preregisterBtn(_ sender: UIButton) {
        let usersName = name.text
        let usersEmail = email.text
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
//    func showMailComposer(name: String, email: String? ){
//        guard MFMailComposeViewController.canSendMail() else {
//            print("Email is not supported on this device")
//            return
//        }
//        let composer =  MFMailComposeViewController()
//        composer.mailComposeDelegate = self
//        composer.setToRecipients(["Chris.csrstaff@gmail.com"])
//        composer.setSubject("\(name.text)-Pregistation request")
//        composer.setMessageBody("It works! See See. My prefered email is  \(email.text)", isHTML: false)
//        present(composer, animated: true)
//    }
    
}
extension PreRegistrationViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            controller.dismiss(animated: true, completion: nil)
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
}
