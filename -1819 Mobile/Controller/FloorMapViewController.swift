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
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.hidesBarsWhenVerticallyCompact = true
        if let floorObj = floorObj{
            configureView(floorObj: floorObj)

        }else{
            print("Not able to load room object")
        }
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if ScrollView.zoomScale > 1{
            ScrollView.zoomScale = 1
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.hidesBarsWhenVerticallyCompact = false
        if ScrollView.zoomScale > 1{
            ScrollView.zoomScale = 1
        }
        if (self.isMovingFromParent) {
          UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }

    }

    func configureView(floorObj: FloorsMO){
        guard let selectedFloorNameImagePath = floorObj.mapImage else{return}
        guard let selectedFloorName = floorObj.name else{return}
        navigationItem.title = selectedFloorName
        imageView.image = UIImage(named: selectedFloorNameImagePath)
        imageView.isAccessibilityElement = true
        imageView.accessibilityLabel = "A map image of \(selectedFloorName) Rooms"

    }
    
     @objc func canRotate() -> Void {}
   
}
extension FloorMapViewController:  UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {

        if scrollView.zoomScale > 1{
            if let mapImage = imageView.image {
                let ratioW = imageView.frame.width / mapImage.size.width
                let ratioH = imageView.frame.height / mapImage.size.height

                let ratio = ratioW < ratioH ? ratioW : ratioH
                let newWidth = mapImage.size.width * ratio
                let newHeight = mapImage.size.height * ratio

                let conditionLeft = newWidth * scrollView.zoomScale > imageView.frame.width
                let left = 0.5 * (conditionLeft ? newWidth - imageView.frame.width : (scrollView.frame.width - scrollView.contentSize.width))

                let conditionTop = newHeight * scrollView.zoomScale > imageView.frame.height

                let top = 0.5 * (conditionTop ? newHeight - imageView.frame.height : (scrollView.frame.height - scrollView.contentSize.height))

                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
            }
        }else{
            scrollView.contentInset = .zero
        }
    }
}
