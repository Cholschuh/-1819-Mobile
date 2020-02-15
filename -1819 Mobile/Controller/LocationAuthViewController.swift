//
//  LocationAuthorizationViewController.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 2/13/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//

import UIKit
import KontaktSDK

class LocationAuthViewController: UIViewController, KTKBeaconManagerDelegate{
    
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
    
}
extension LocationAuthViewController{
    
    func beaconManager(_ manager: KTKBeaconManager, didChangeLocationAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse{
            self.performSegue(withIdentifier: "goToBeaconDiscovery", sender:self)
        }
    }
    
}
