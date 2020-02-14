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
    
    override func viewDidDisappear(_ animated: Bool) {
        //self.dismiss(animated: false, completion: nil)
    }
    
    // initialize beacon manager
    var beaconManager : KTKBeaconManager!
    
    @IBAction func enableLocAuth(_ sender: UIButton) {
        // initialize beacon manager
        beaconManager = KTKBeaconManager(delegate: self)
        beaconManager.requestLocationAlwaysAuthorization()
    }
    
}
extension LocationAuthViewController: KTKBeaconManagerDelegate, CLLocationManagerDelegate {
    
    func beaconManager(_ manager: KTKBeaconManager, didChangeLocationAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedAlways
    {
            // When status changes to CLAuthorizationStatus.authorizedAlways
            // e.g. after calling beaconManager.requestLocationAlwaysAuthorization()
            // we can start region monitoring from here
            print("Hello")
            //self.performSegue(withIdentifier: "goToBeaconDiscovey", sender: self)
        }
    }
    
}
