//
//  BeaconDiscoveryViewController.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 2/13/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//

import UIKit
import KontaktSDK

class BeaconDiscoveryViewController: UIViewController, KTKBeaconManagerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var beaconManager : KTKBeaconManager!
    
}
extension BeaconDiscoveryViewController{
    
    func beaconManager(_ manager: KTKBeaconManager, didChangeLocationAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .denied || status == .notDetermined{
            //self.performSegue(withIdentifier: "", sender:self)
            print("BeaconStatusChanged")
        }
    }
    
}
