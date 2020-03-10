//
//  RoomDetailsViewController.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 2/19/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//

import UIKit

protocol roomDetailDismissDelegate {
    func didDismiss(result: Bool)
}
class RoomDetailsViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var roomNameLbl: UILabel!
    @IBOutlet weak var roomInfoTextView: UITextView!
    @IBOutlet weak var imgScrollView: UIScrollView!
    @IBOutlet weak var imgPageControl: UIPageControl!
    @IBOutlet weak var closeBtnView: UIView!
    @IBOutlet weak var photoView: UIView!
    
    var roomObj: RoomsMO?
    var seguedFromBeaconDiscovery: Bool = false
    var dismissDelegate: roomDetailDismissDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let roomObj = roomObj{
            configureView(roomObj: roomObj)
        }else{
            print("Not able to load room object")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if roomInfoTextView.contentOffset.y > 0 {
            roomInfoTextView.contentOffset = CGPoint(x: 0, y: 0)
            // Or use scrollRectToVisible, scrollRangeToVisible, etc.
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        if seguedFromBeaconDiscovery{
            dismissDelegate.didDismiss(result: true)
        }
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureView(roomObj: RoomsMO){
        self.imgScrollView.translatesAutoresizingMaskIntoConstraints = false
        roomNameLbl.text = roomObj.name
        roomInfoTextView.text = roomObj.information
        let roomPhotos = roomObj.photos!
        let roomPhotosCount = roomPhotos.count
        imgPageControl.numberOfPages = roomPhotosCount
        
        for i in 0..<roomPhotosCount {
            
            let imageView = UIImageView()
            imageView.contentMode = .scaleToFill
            imageView.clipsToBounds = true
            imageView.frame.size.height = 360

            imageView.isAccessibilityElement = true
            view.frame.size.height = imgScrollView.frame.size.height
            imageView.image = UIImage(named: roomPhotos[i].path ?? "")
            imageView.accessibilityLabel = roomPhotos[i].altText
            //sets starting x postion for each photo.
            let xPos = CGFloat(i) * self.view.bounds.size.width
            print(imgScrollView.frame.size.height)
            
            imageView.frame = CGRect(x: xPos, y: 0, width: view.frame.size.width, height: 360)
            
            imgScrollView.contentSize.width = view.frame.size.width*CGFloat(i+1)
            imgScrollView.addSubview(imageView)
        }
        _ = []
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x/scrollView.frame.width
        imgPageControl.currentPage = Int(page)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

