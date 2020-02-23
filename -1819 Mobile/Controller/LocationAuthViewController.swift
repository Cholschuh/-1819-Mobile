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
    var seguedFromBeaconDiscovReq: Bool = false
   
    @IBOutlet weak var enableLocAuthBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        enableLocAuthBtn.layer.cornerRadius = enableLocAuthBtn.frame.size.height/2
        if seguedFromBeaconDiscovReq{
            removePreviousViewControllerFromStack()
            seguedFromBeaconDiscovReq = false
        }

    }
    
    /// initialize beacon manager
    var beaconManager : KTKBeaconManager!
    @IBAction func enableLocAuth(_ sender: UIButton) {
        /// initialize beacon manager and request location services.
        beaconManager = KTKBeaconManager(delegate: self)
        beaconManager.requestLocationAlwaysAuthorization()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        ///Set the BeaconDiscoveryViewController Bool varible (seguedFromAuthReq) to True
        ///when seguing to the controller. Used to dismiss previous this viewController from the
        /// stack after segue is preformed
        if segue.identifier == "goToBeaconDiscovery" {
            let destinationVC = segue.destination as! BeaconDiscoveryViewController
            destinationVC.seguedFromAuthReq = true
        }
    }
    
    func removePreviousViewControllerFromStack(){
        ///Removes Previous View From Stack
        var viewControllers = navigationController?.viewControllers
        let viewCount = viewControllers!.count
        if viewCount > 0 {
            viewControllers?.remove(at: viewCount - 2)
            navigationController?.setViewControllers(viewControllers!, animated: false)
        }
    }
    
    
}
extension LocationAuthViewController{
    
    func beaconManager(_ manager: KTKBeaconManager, didChangeLocationAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse{
            self.performSegue(withIdentifier: "goToBeaconDiscovery", sender:self)
        }else if status == .denied || status == .restricted{
            //Change picture
            //Change text label
        }
    }
    
}
