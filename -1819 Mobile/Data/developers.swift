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

        let developer1 = developer(fullName: "Chris Holschuh", shortBio: "Chris Holschuh is a senior at the University of Cincinnati finishing up his bachelors degree in Software Development. Chris achieved assoitate degree in Web Development from the University in 2007. Chris is currently employeed at the University with IT@UC Endpoint Managment as a System Administrator.", photoPath: "Chris")

        let developer2 = developer(fullName: "Aidan Burns", shortBio: "Aidan Burns is a fifth-year senior at the University of Cincinnati studying Information Technology with a focus in Cybersecurity. Aidan also works at the University full time in the central IT department as a computer user support specialist for staff in the Administration and Finance departments on campus. Outside of the office or the classroom Aidan enjoys amateur photography, listening to music and playing online games with friends.", photoPath: "Aidan")
      
        let developer3 = developer(fullName: "Cameron Demoss", shortBio: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", photoPath: "Cameron")
        
        
        array.append(developer1)
        array.append(developer2)
        array.append(developer3)

        
        return array
    }
}
