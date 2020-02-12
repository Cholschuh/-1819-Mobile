//
//  ViewController.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 1/25/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//

import UIKit
import KontaktSDK

class NavigationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        //navigationController?.setNavigationBarHidden(true, animated: true)
        arrayOfMenuItems = menuItems().getData()
        tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
       //navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    var arrayOfMenuItems:[menuItem] = [menuItem]()
    var currentIndex: Int = 0

    @IBOutlet weak var tableView: UITableView!
    
}
extension NavigationViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell") as? menuItemCell {
            cell.configureCell(menuItem: arrayOfMenuItems[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedItemName = arrayOfMenuItems[currentIndex].text
        switch selectedItemName{
            
        case "Maps":
        self.performSegue(withIdentifier: "goToMaps", sender: self)
            print("Maps")
        case  "Building Information":
            self.performSegue(withIdentifier: "goToBuildingInfo", sender: self)
            print("Building Information")
        case "Beacon Discovery":
            self.performSegue(withIdentifier: "goToBeaconDiscovey", sender: self)
            print("Beacon Discovery")
        case "Check-in Pre-registation":
            self.performSegue(withIdentifier: "goToCheckin", sender: self)
            print("Check-in Pre-registation")
        case "Settings":
            self.performSegue(withIdentifier: "goToSettings", sender: self)
            print("Settings")
        case .none:
            return
        case .some(_):
            return
        }
    }
}


