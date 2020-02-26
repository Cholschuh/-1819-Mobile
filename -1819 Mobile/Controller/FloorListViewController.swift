//
//  FloorListViewController.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 2/18/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//

import UIKit

class FloorListViewController: UIViewController {
    
    var floorObjects: [FloorsMO] = []
    var currentIndex: Int = 0
    var selectedMenuOption: String = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        floorObjects = coreDataHelper.getFloorObject()
        tableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToRoomList" {
            let destinationVC = segue.destination as! RoomListViewController
            destinationVC.floorObj = floorObjects[currentIndex]
        }
    }
}
extension FloorListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return floorObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "floorCell") as? floorListCell {
            cell.configureCell(floorObj: floorObjects[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedMenuOption == "Maps"{
            self.performSegue(withIdentifier: "goToMapView", sender: self)
        }else if selectedMenuOption == "Building Information"{
            self.performSegue(withIdentifier: "goToRoomList", sender: self)
        }
        
    }
}
