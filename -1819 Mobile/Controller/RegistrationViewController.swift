//
//  RegistrationViewController.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 2/13/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//

import UIKit
import MessageUI

class RegistrationViewController: UIViewController{
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var preRegisterBtn: UIButton!
    @IBOutlet weak var nameAlert: UILabel!
    @IBOutlet weak var emailAlert: UILabel!
    
    var usersFullName: String?
    var usersPreferredEmail: String?
    var messageSent: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preRegisterBtn.layer.cornerRadius = preRegisterBtn.frame.size.height/2
        ///calls extension functions to dismiss keyboard when textfield looses focus
        self.setupHideKeyboardOnTap()
        nameAlert.isHidden = true
        emailAlert.isHidden = true
    }
    
    @IBAction func preRegisterBtn(_ sender: UIButton) {
        view.endEditing(true)
        usersFullName = nameTxt.text
        usersPreferredEmail = emailTxt.text
        
        if !usersFullName!.isEmpty && !usersPreferredEmail!.isEmpty{
            usersPreferredEmail = usersPreferredEmail!.trimmingCharacters(in: .whitespaces)
            usersFullName = usersFullName!.trimmingCharacters(in: .whitespaces)
            if validationHelper.isEmailVaild(emailAddress: usersPreferredEmail!){
                showMailComposer(usersFN: usersFullName!, usersPrefEmail: usersPreferredEmail!)
            }else{
                emailAlert.isHidden = false
                return
            }
        }
        else if !usersFullName!.isEmpty && usersPreferredEmail!.isEmpty{
            usersFullName = usersFullName!.trimmingCharacters(in: .whitespaces)
            showMailComposer(usersFN: usersFullName!, usersPrefEmail: "NA")
        }
        else{
            
            nameAlert.isHidden = false
            return
        }
    }
    
    
    func showMailComposer(usersFN: String, usersPrefEmail: String){
        guard MFMailComposeViewController.canSendMail() else {
            print("Email is not supported on this device")
            return
        }
        var messageBody: String = "Hi my name is \(usersFN). I am reaching out to you today as I would like to pre-registered for the check-in process at 1819. "
        if usersPrefEmail == "NA"{
            messageBody.append("Please use the email address I am sending from as my prefered email for this registration.")
        }else {
            messageBody.append("Please use \(usersPrefEmail) as my prefered email for this registration.")
        }
        
        let composer =  MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["Chris.csrstaff@gmail.com"])
        composer.setSubject("\(usersFN)'s Pre-registation request")
        composer.setMessageBody(messageBody, isHTML: false)
        present(composer, animated: true)
    }
    
}
extension RegistrationViewController: MFMailComposeViewControllerDelegate, UITextFieldDelegate{
    
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
        case .saved, .sent:
            print("Sent")
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
    
    /// Call this once to dismiss open keyboards by tapping anywhere in the view controller
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }
    
    /// Dismisses the keyboard from self.view
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        nameAlert.isHidden = true
        emailAlert.isHidden = true
        return true
    }
    
}

