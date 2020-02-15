//
//  BeaconDiscoveryViewController.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 2/13/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//

import UIKit
import KontaktSDK

class BeaconDiscoveryViewController: UIViewController{
    var beaconManager : KTKBeaconManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Sets Secure Beacon
        beaconManager = KTKBeaconManager(delegate: self)
        
        let mySecureProximityUuid = UUID(uuidString: "f7826da6-4fa2-4e98-8024-bc5b71e0893e")
        let secureRegion = KTKSecureBeaconRegion(proximityUUID: mySecureProximityUuid!, identifier: "1819")
        
        if KTKBeaconManager.isMonitoringAvailable() {
            beaconManager.startMonitoring(for: secureRegion)
            beaconManager.startRangingBeacons(in: secureRegion)
        }else {
            print("Something went wrong")
        }
    }
}

extension BeaconDiscoveryViewController: KTKBeaconManagerDelegate {
    
    func beaconManager(_ manager: KTKBeaconManager, didChangeLocationAuthorizationStatus status: CLAuthorizationStatus) {
//        if status == .authorizedAlways || status == .authorizedWhenInUse{
//        }
        if status == .denied || status == .notDetermined{
            //self.performSegue(withIdentifier: "", sender:self)
            print("BeaconStatusChanged")
        }
    }
    func beaconManager(_ manager: KTKBeaconManager, didStartMonitoringFor region: KTKBeaconRegion) {
        // Do something when monitoring for a particular
        // region is successfully initiated
        print("Monitoring for predfined Region")
        
    }
    
    func beaconManager(_ manager: KTKBeaconManager, didEnter region: KTKBeaconRegion) {
        // Decide what to do when a user enters a range of your region; usually used
        // for triggering a local notification and/or starting a beacon ranging
        print("You've enterd my region of beacons")
        //beaconManager.startRangingBeacons(in: region)
        manager.startRangingBeacons(in: region)
    }
    
    func beaconManager(_ manager: KTKBeaconManager, didExitRegion region: KTKBeaconRegion) {
        // Decide what to do when a user exits a range of your region; usually used
        // for triggering a local notification and stoping a beacon ranging
        print("You've left my beacon region")
        manager.stopRangingBeacons(in: region)
    }
    
    func beaconManager(_ manager: KTKBeaconManager, didRangeBeacons beacons: [CLBeacon], in region: KTKBeaconRegion) {
        // if beacons allow the the immediate beacon change the UI based on its color value, name, and promimity infomation.
        if beacons.count > 0 {
            let nearestBeacon = beacons.first!
            
            switch nearestBeacon.proximity{
            case .immediate:
                print("Nearest Beacon is \(nearestBeacon.ktk_minor) \(nearestBeacon.ktk_major)")
                manager.stopRangingBeacons(in: region)
                break
            case .far:
                //print("Far \(beaconNamesByMinor              [nearestBeacon.minor.intValue]!)")
                break
            case .near:
                //print("Near \(beaconNamesByMinor[nearestBeacon.minor.intValue]!)")
                break
            case .unknown:
                //print("Unknown \(beaconNamesByMinor[nearestBeacon.minor.intValue]!)")
                break
            @unknown default:
                //print("Error")
                break
            }
        }
        
    }
    
}
