//
//  developerCell.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 3/19/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//

import Foundation
import UIKit

class developerCell: UITableViewCell {
  
    @IBOutlet weak var devphoto: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cellTextView: UITextView!
    
    func configureCell(developer: developer){
        devphoto.image = UIImage(named: developer.photoPath ?? "")
        nameLabel.text = developer.fullName
        cellTextView.text = developer.shortBio
        
    }
    
}

