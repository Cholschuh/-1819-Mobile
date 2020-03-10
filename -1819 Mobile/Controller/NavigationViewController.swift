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
    @IBOutlet weak var tableView: UITableView!
    var arrayOfMenuItems:[menuItem] = [menuItem]()
    var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navbarTransparentForIOS12()
        //        arrayOfMenuItems = menuItems().getData()
        //        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
        arrayOfMenuItems = menuItems().getData()
        tableView.reloadData()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFloorList" {
            let destinationVC = segue.destination as! FloorListViewController
            destinationVC.selectedMenuOption = arrayOfMenuItems[currentIndex].text ?? ""
            
        }
    }
    
    func navbarTransparentForIOS12(){
        
        if #available(iOS 13.0, *){
            // Do nothing
        }else{
            // For iOS 12
            // removes line at bottom of navigation bar
            navigationController?.navigationBar.shadowImage = UIImage()
            
            // makes navigation bar completely transparent
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.isTranslucent = true
        }
        
    }
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
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedItemName = arrayOfMenuItems[currentIndex].text
        switch selectedItemName{
        case "Maps":
            self.performSegue(withIdentifier: "goToFloorList", sender: self)
        case  "Building Information":
            self.performSegue(withIdentifier: "goToFloorList", sender: self)
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

