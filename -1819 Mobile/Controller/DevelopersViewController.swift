//
//  DevelopersViewController.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 3/19/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//

import UIKit

class DevelopersViewController: UIViewController {
    var arrayOfDevelopers:[developer] = [developer]()
     var currentIndex: Int = 0
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        arrayOfDevelopers = developers().getData()
        tableView.reloadData()
    }
    
    
}
extension DevelopersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfDevelopers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "developerCell") as? developerCell{
            cell.configureCell(developer: arrayOfDevelopers[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        //        if selectedMenuOption == "Maps"{
        //            self.performSegue(withIdentifier: "goToMapView", sender: self)
        //        }else if selectedMenuOption == "Building Information"{
        //            self.performSegue(withIdentifier: "goToRoomList", sender: self)
        //        }
        //
    }
}
