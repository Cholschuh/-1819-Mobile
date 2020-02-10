//
//  menuItems.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 2/10/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//

import Foundation
import UIKit

class menuItems {
    
    func getData() -> [menuItem] {
        var array: [menuItem] = [menuItem] ()
        // needs two viewcontrollers
        let menuItem1 = menuItem(text: "Maps")
        //Needs three viewcontrollers
        let menuItem2 = menuItem(text: "Building Information")
        //Needs one view controller Will link to one View contoller form Buidling Information
        let menuItem3 = menuItem(text: "Beacon Discovery")
        //Needs One view Controller
        let menuItem4 = menuItem(text: "Check-in Pre-registation")
        // Needs One View Controller 
        let menuItem5 = menuItem(text: "Settings")
        
        array.append(menuItem1)
        array.append(menuItem2)
        array.append(menuItem3)
        array.append(menuItem4)
        array.append(menuItem5)
        
        return array
    }
}
