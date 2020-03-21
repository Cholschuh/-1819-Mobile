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
    var selectedIndex = -1
    var isExpanded :Bool = false
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        arrayOfDevelopers = developers().getData()
        tableView.reloadData()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 351
        

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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      if (self.selectedIndex == indexPath.row && isExpanded == true)
            {
                return 351
            }
      else {
                return 128
            }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        
        if selectedIndex == indexPath.row

        {

        if self.isExpanded == false

            {

            self.isExpanded = true

            }

            else {

            self.isExpanded = false

            }

        }

        else {

            self.isExpanded = true

            

        }

        self.selectedIndex = indexPath.row

        tableView.reloadRows(at: [indexPath], with: .automatic)

        //        if selectedMenuOption == "Maps"{
        //            self.performSegue(withIdentifier: "goToMapView", sender: self)
        //        }else if selectedMenuOption == "Building Information"{
        //            self.performSegue(withIdentifier: "goToRoomList", sender: self)
        //        }
        //
    }
}
