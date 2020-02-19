//
//  floorListCell.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 2/18/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//

import Foundation
import UIKit

class floorListCell: UITableViewCell {
    @IBOutlet weak var floorLbl: UILabel!
    
    func configureCell(floorObj: FloorsMO){
        floorLbl.text = floorObj.name
    }
}
