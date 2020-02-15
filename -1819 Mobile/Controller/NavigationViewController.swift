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
        arrayOfMenuItems = menuItems().getData()
        tableView.reloadData()
    }
    
    @IBOutlet weak var tableView: UITableView!
    var arrayOfMenuItems:[menuItem] = [menuItem]()
    var currentIndex: Int = 0
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
        case  "Building Information":
            self.performSegue(withIdentifier: "goToBuildingInfo", sender: self)
        case "Beacon Discovery":
            ///Check to see if Location Authorization has been granted and displays the correct segue
            switch KTKBeaconManager.locationAuthorizationStatus(){
            case .notDetermined, .denied, .restricted:
                self.performSegue(withIdentifier: "goToLocServicesReq", sender: self)
            case .authorizedAlways, .authorizedWhenInUse:
                self.performSegue(withIdentifier: "goToBeaconDiscovey", sender: self)
            @unknown default:
                print("@unknown default")
            }
        case "Check-in Pre-registation":
            self.performSegue(withIdentifier: "goToCheckin", sender: self)
        case "Settings":
            self.performSegue(withIdentifier: "goToSettings", sender: self)
        case .none, .some(_) :
            return
        }
    }
}

