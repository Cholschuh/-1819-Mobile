//
//  CheckNetworkViewController.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 3/2/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//

import UIKit

class CheckNetworkViewController: UIViewController {
    
    var seguedFromBeaconDiscovReq: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        if seguedFromBeaconDiscovReq{
            removePreviousViewControllerFromStack()
            seguedFromBeaconDiscovReq = false
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
