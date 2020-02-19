//
//  roomListCell.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 2/18/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//

import Foundation
import UIKit

class roomListCell: UITableViewCell {
    @IBOutlet weak var roomLbl: UILabel!
    
    func configureCell(roomObj: RoomsMO){
        roomLbl.text = roomObj.name
    }
    
}
