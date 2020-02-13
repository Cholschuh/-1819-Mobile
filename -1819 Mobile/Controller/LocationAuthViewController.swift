//
//  LocationAuthorizationViewController.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 2/13/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//

import UIKit
import KontaktSDK

class LocationAuthViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // initialize beacon manager
    var beaconManager : KTKBeaconManager!
    
    @IBAction func enableLocAuth(_ sender: UIButton) {
        // initialize beacon manager
        beaconManager = KTKBeaconManager(delegate: self)
        beaconManager.requestLocationAlwaysAuthorization()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension LocationAuthViewController: KTKBeaconManagerDelegate {
    
    func beaconManager(_ manager: KTKBeaconManager, didChangeLocationAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            // When status changes to CLAuthorizationStatus.authorizedAlways
            // e.g. after calling beaconManager.requestLocationAlwaysAuthorization()
            // we can start region monitoring from here
            
        }
        
    }
}
