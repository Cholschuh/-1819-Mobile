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
        let menuItem1 = menuItem(text: "Maps")
        let menuItem2 = menuItem(text: "Building Information")
        let menuItem3 = menuItem(text: "Beacon Discovery")
        let menuItem4 = menuItem(text: "Check-in Pre-registation")
        let menuItem5 = menuItem(text: "Settings")
        
        array.append(menuItem1)
        array.append(menuItem2)
        array.append(menuItem3)
        array.append(menuItem4)
        array.append(menuItem5)
        
        return array
    }
}
