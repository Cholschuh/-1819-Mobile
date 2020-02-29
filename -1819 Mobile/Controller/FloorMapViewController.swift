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
    var imageZoomed: Bool = false
    var initialCenter = CGPoint()
    var selectedFloorNameImagePath: String = ""
    var selectedFloorName: String = ""
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
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (self.isMovingFromParent) {
          UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }

    }
    
    @IBAction func panImage(_ recognizer: UIPanGestureRecognizer) {

        guard let recognizerView = recognizer.view else{return}
        let translation =  recognizer.translation(in: view)
        if recognizer.state == .began{
            self.initialCenter = recognizerView.center
        }
        if !recognizerView.frame.contains(recognizer.location(in: recognizerView)){
            recognizerView.center = self.initialCenter
            recognizer.setTranslation(.zero, in: view)
            
        }else{
            let newCenter = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
            recognizerView.center = newCenter
            //recognizerView.center.x += translation.x
            //recognizerView.center.y += translation.y
            recognizer.setTranslation(.zero, in: view)
        }
        
        
//        if !recognizerView.frame.contains(recognizer.location(in: recognizerView)){
//            recognizerView.center = self.initialCenter
//        }
        
//        if recognizerView.frame.contains(recognizer.location(in: recognizerView)) {
//            //Gesture started inside the pannable view. Do your thing.
//            //recognizerView.center = orginCenter
//            recognizerView.center.x += translation.x
//            recognizerView.center.y += translation.y
//            recognizer.setTranslation(.zero, in: view)
//        }else{
//            recognizerView.center = orginCenter
//            recognizer.setTranslation(.zero, in: view)
//        }
        
        
        
    }
    @IBAction func rotateImage(_ recognizer: UIRotationGestureRecognizer) {
        
//        if let recognizerView = recognizer.view {
//            recognizerView.transform = imageView.transform.rotated(by: recognizer.rotation)
//            recognizer.rotation = 0
//        }
    }
    @IBAction func tapImage(_ sender: Any) {
        if (!imageZoomed) {
            scaleImageUp()
            imageZoomed = true
        } else {
            normalizeImage()
            imageZoomed = false
        }
    }
    @IBAction func scaleImage(_ recognizer: UIPinchGestureRecognizer) {
        
        guard let recognizerView = recognizer.view else{return}
        
        recognizerView.transform = recognizerView.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
        recognizer.scale = 1
        //        imageView.transform = CGAffineTransform(scaleX: (sender as AnyObject).scale, y: (sender as AnyObject).scale)
        
    }
    
    func configureView(floorObj: FloorsMO){
        guard let selectedFloorNameImagePath = floorObj.mapImage else{return}
        guard let selectedFloorName = floorObj.name else{return}
        navigationItem.title = selectedFloorName
        imageView.image = UIImage(named: selectedFloorNameImagePath)
        imageView.isAccessibilityElement = true
        imageView.accessibilityLabel = "A map image of \(selectedFloorName) Rooms"
        
    }
    
    
    func scaleImageUp() {
        imageView.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
        imageZoomed = true
    }
    
    func normalizeImage() {
        imageView.transform = CGAffineTransform.identity
        imageZoomed = false
    }
    
     @objc func canRotate() -> Void {}
   
}
extension FloorMapViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
