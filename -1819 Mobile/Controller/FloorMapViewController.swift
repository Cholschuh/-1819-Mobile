//
//  FloorMapViewController.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 2/23/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//

import UIKit


class FloorMapViewController: UIViewController {
    var floorObj: FloorsMO?
    var selectedFloorNameImagePath: String = ""
    var selectedFloorName: String = ""
    
    @IBAction func rotateImage(_ sender: Any) {
    }
    @IBAction func tapImage(_ sender: Any) {
    }
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let floorObj = floorObj{
            configureView(floorObj: floorObj)
        }else{
            print("Not able to load room object")
        }
        
        
    }
override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    @IBAction func scaleImage(_ sender: Any) {
        imageView.transform = CGAffineTransform(scaleX: (sender as AnyObject).scale, y: (sender as AnyObject).scale)
        }
    
    func configureView(floorObj: FloorsMO){
        guard let selectedFloorNameImagePath = floorObj.mapImage else{return}
        guard let selectedFloorName = floorObj.name else{return}
        imageView.image = UIImage(named: selectedFloorNameImagePath)
    }
}
