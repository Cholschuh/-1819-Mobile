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
    var selectedFloor: String = ""
    @IBOutlet weak var imageScrollView: UIScrollView!
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        if let floorObj = floorObj{
//            //configureView(floorObj: floorObj)
//        }else{
//            print("Not able to load room object")
//        }
        
        
    }
override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    @IBAction func scaleImage(_ sender: Any) {
        imageView.transform = CGAffineTransform(scaleX: (sender as AnyObject).scale, y: (sender as AnyObject).scale)
        }
    

}
extension FloorMapViewController: UIScrollViewDelegate {}
