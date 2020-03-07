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
    
    @IBOutlet weak var BeaconLbl: UILabel!
    var beaconManager : KTKBeaconManager!
    var seguedFromAuthReq: Bool = false
    var detectedRoom: RoomsMO?
    weak var delegate: BeaconDiscoveryViewController?
    let generator = UINotificationFeedbackGenerator()
    let secureRegion = KTKSecureBeaconRegion(proximityUUID: UUID(uuidString: "f7826da6-4fa2-4e98-8024-bc5b71e0893e")!, identifier: "1819")
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
         
       
        ///Removes Previous View from stack if seguing from AuthReq Controller
        if seguedFromAuthReq{
            removePreviousViewControllerFromStack()
            seguedFromAuthReq = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        networkCheckHelper().startMonitor {[weak self] reachable in
                 guard let strongSelf = self else { return }
                 strongSelf.checkNetworkConnection(reachable)
             }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.navigationController?.viewControllers.firstIndex(of: self) == nil {
            // Back button pressed because self is no longer in the navigation stack.
            beaconManager.stopMonitoring(for: secureRegion)
            beaconManager.stopRangingBeacons(in: secureRegion)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
//        networkCheckHelper().startMonitor {[weak self] reachable in
//            guard let strongSelf = self else { return }
//            strongSelf.checkNetworkConnection(reachable)
//        }
    
        /// instantiates  new beacon Manager
        beaconManager = KTKBeaconManager(delegate: self)
        
        if KTKBeaconManager.isMonitoringAvailable()  {
            beaconManager.startMonitoring(for: secureRegion)
            beaconManager.startRangingBeacons(in: secureRegion)
        }else {
            print("Something went wrong")
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        ///Checks to make sure user has not navigated away from the BeaconDiscoveryViewController
        if self.navigationController?.viewControllers.firstIndex(of: self) == nil {
            return false
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAuthReq" {
            ///Set the BeaconDiscoveryViewController Bool varible (seguedFromAuthReq) to True
            ///when seguing to the controller. Used to dismiss previous this viewController from the
            ///stack after segue is preformed
            let destinationVC = segue.destination as! LocationAuthViewController
            destinationVC.seguedFromBeaconDiscovReq = true
        }else if segue.identifier == "goToRoomDetails" {
            /// Generates Haptic feedback, gets detected room name, writes room to VistedRoomsMO, passes room object and seguedIndetifier  before presenting RoomDetailsViewController
            generator.notificationOccurred(.success)
            guard let toVisitRoomName = detectedRoom?.name else {return}
            coreDataHelper.recordVisitedLoc(name: toVisitRoomName)
            let destinationVC = segue.destination as! RoomDetailsViewController
            destinationVC.dismissDelegate = self
            destinationVC.roomObj = detectedRoom
            destinationVC.seguedFromBeaconDiscovery = true
            
        }else if segue.identifier == "goToLostInternet"{
            let destinationVC = segue.destination as! CheckNetworkViewController
            destinationVC.seguedFromBeaconDiscovReq = true
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
    
    func handleModalDismissed() {
        beaconManager.startRangingBeacons(in: secureRegion)
    }
    
    private func checkNetworkConnection(_ reachable: Reachable){
        if reachable == .no {
            DispatchQueue.main.async {
        self.performSegue(withIdentifier: "goToLostInternet", sender:self)
            }
        }
    }
    
}

extension BeaconDiscoveryViewController: KTKBeaconManagerDelegate , roomDetailDismissDelegate {
    
    func beaconManager(_ manager: KTKBeaconManager, didChangeLocationAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .denied || status == .notDetermined{
            self.performSegue(withIdentifier: "goToAuthReq", sender:self)
            
        }
    }
    func beaconManager(_ manager: KTKBeaconManager, didStartMonitoringFor region: KTKBeaconRegion) {
        /// Do something when monitoring for a particular
        /// region is successfully initiated
        
    }
    
    func beaconManager(_ manager: KTKBeaconManager, didEnter region: KTKBeaconRegion) {
        /// Decide what to do when a user enters a range of your region; usually used
        /// for triggering a local notification and/or starting a beacon ranging
        manager.startRangingBeacons(in: region)
    }
    
    func beaconManager(_ manager: KTKBeaconManager, didExitRegion region: KTKBeaconRegion) {
        /// Decide what to do when a user exits a range of your region; usually used
        /// for triggering a local notification and stoping a beacon ranging
        manager.stopRangingBeacons(in: region)
    }
    
    func beaconManager(_ manager: KTKBeaconManager, didRangeBeacons beacons: [CLBeacon], in region: KTKBeaconRegion) {
        if beacons.count > 0 {
            let nearestBeacon = beacons.first!
            switch nearestBeacon.proximity{
            case .immediate:
                BeaconLbl.text = "\(nearestBeacon.ktk_minor)  \(nearestBeacon.ktk_major)"
                detectedRoom = try? coreDataHelper.getDetectedRoomWThrow(beaconMajorVal: nearestBeacon.ktk_major.stringValue, beaconMinorVal: nearestBeacon.ktk_minor.stringValue)
                if detectedRoom != nil {
                    guard let detectedRoomName = detectedRoom?.name else {return}
                    if !coreDataHelper.roomHasBeenVisited(roomName:
                        detectedRoomName){
                        manager.stopRangingBeacons(in: region)
                        self.performSegue(withIdentifier: "goToRoomDetails", sender: self)
                    }
                    
                }
                break
            case .far:
                break
            case .near:
                break
            case .unknown:
                break
            @unknown default:
                break
            }
        }
        
    }
    
    func didDismiss(result: Bool) {
        if result{
            beaconManager.startRangingBeacons(in: secureRegion)
        }
    }
}
