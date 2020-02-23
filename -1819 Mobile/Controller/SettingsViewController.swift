//
//  SettingsViewController.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 2/13/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//

import UIKit
import MessageUI

class SettingsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "Orca"))
        // Do any additional setup after loading the view.
    }
    
    func showMailComposer(){
        guard MFMailComposeViewController.canSendMail() else {
            print("Email is not supported on this device")
            return
        }
        let messageBody: String = "When using the 1819 Mobile application I ran into the following problem. Please see below for details \n\nSteps taken to produce the problem:\n\n\nWhat happens when the problem occurs "
        let composer =  MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["Chris.csrstaff@gmail.com"])
        composer.setSubject("Bug Report: 1819 Mobile Applciaiton")
        composer.setMessageBody(messageBody, isHTML: false)
        present(composer, animated: true)
    }
}
extension SettingsViewController: MFMailComposeViewControllerDelegate {
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath {
        case [0, 0]:
            coreDataHelper.clearAllVisitedLoc()
        case [1, 0]:
            showMailComposer()
        case [2, 0]:
            print("Team page")
        default:
            return
        }
    }
    
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
}
