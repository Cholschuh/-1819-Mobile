//
//  SettingsViewController.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 2/13/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "Orca"))
        // Do any additional setup after loading the view.
    }
    
    //    @IBAction func clearVisitedRoomsBtn(_ sender: UIButton) {
    //        coreDataHelper.clearAllVisitedLoc()
    //    }
}
extension SettingsViewController {
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath {
        case [0, 0]:
            coreDataHelper.clearAllVisitedLoc()
        case [1, 0]:
            print("Popup Email")
        case [2, 0]:
            print("Team page")
        default:
            return
        }
        
    }
}
