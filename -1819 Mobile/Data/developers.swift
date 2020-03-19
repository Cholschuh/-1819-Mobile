//
//  developers.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 3/18/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//

import Foundation
import UIKit

class developers {
    
    func getData() -> [developer] {
        var array: [developer] = [developer] ()

        let developer1 = developer(fullName: "Chris Holschuh", shortBio: "Stuff", photoPath: "Chris")

        let developer2 = developer(fullName: "Aidan Burns", shortBio: "Stuff", photoPath: "Aidan")
      
        let developer3 = developer(fullName: "Cameron Demoss", shortBio: "Stuff", photoPath: "Cameron")
        
        
        array.append(developer1)
        array.append(developer2)
        array.append(developer3)

        
        return array
    }
}
