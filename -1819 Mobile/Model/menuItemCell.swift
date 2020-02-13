//
//  menuItemTCell.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 2/12/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//

import Foundation
import UIKit

class menuItemCell: UITableViewCell {
    @IBOutlet weak var cellLabel: UILabel!
    func configureCell(menuItem: menuItem){
        cellLabel.text = menuItem.text
    }
    
}

