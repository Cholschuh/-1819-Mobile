//
//  coreDataHelper.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 2/15/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//

import UIKit
import Foundation
import CoreData


class coreDataHelper: NSObject {
    
    
    
    //provides a context for Appdelegate to the persistent Container
    private class func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
        
    }
    
    
    // Create a record in the VistedRoomMO Entity with the room name
    class func recordVisitedLoc(name: String)-> Bool{
        let context = getContext()
        let vistedRooms = VisitedRoomsMO(context: context)
        vistedRooms.name = name
        
        do {
            try context.save()
            return true
        }catch{
            print(error.localizedDescription)
            return false
        }
    }
    // Clears all records in the visistedRoomMO data store
    class func clearAllVisitedLoc () -> Bool{
        let context = getContext()
        let deleteAllRequest = NSBatchDeleteRequest(fetchRequest: VisitedRoomsMO.fetchRequest())
        
        do {
            try context.execute(deleteAllRequest)
            return true
        }catch{
            print (error.localizedDescription)
            return false
        }
    }
    
    // Returning an array of VisitedRoomMO Objects fetches all visited room in the VisitedRoomMO data store
    class func fetchAllVisitedRoomsdData() -> [VisitedRoomsMO]{
            let context = getContext()
            var results: [VisitedRoomsMO] = []
            //let fetch = NSFetchRequest<VisitedRoomsMO>(entityName:"VisitedRoomsMO")
            let fetch = VisitedRoomsMO.createFetchRequest()
            do{
                results = try context.fetch(fetch)
            }catch {
                print(error.localizedDescription)
            }
            return results
        }
    // returns Bool: Searches roomName to detect with room has already been visited
    class func roomHasBeenVisited(roomName: String) -> Bool {
        let context = getContext()
        var records: [VisitedRoomsMO] = []
        let fetch = VisitedRoomsMO.createFetchRequest()
        fetch.predicate = NSPredicate(format: "name = %@",roomName)
        
        do{
            records = try context.fetch(fetch)
            if records.count > 0 {
                return true
            }
        }catch{
            print("What unable to pull data from VisitedRoomsMO entity. Error " + error.localizedDescription)
        }
    return false
    }
    
    //--------Floor<->>Rooms<-->>Photos Methods ------
    
    
    class func getFloorObject() -> [FloorsMO] {
        let context = getContext()
        var floors: [FloorsMO] = []
        let fetchRequest: NSFetchRequest<FloorsMO> = FloorsMO.createfetchRequest()
        let sortDescripter = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescripter]
        do{
          floors = try context.fetch(fetchRequest)
        }catch{
            print("Could not pull numbers")
        }
        return floors
    }
    
//    class func getAllRooms(){
//
//        let context = getContext()
//        var floorObj: [FloorsMO] = []
//        //var fetchedResultsController: NSFetchedResultsController<VisitedRoomsMO>!
//        let request = FloorsMO.createfetchRequest()
//        let sort = NSSortDescriptor(key: "rawRooms.name", ascending: true)
//        request.sortDescriptors = [sort]
//        request.predicate = NSPredicate(format: "floor.name","Floor 1")
////        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: "rawRooms.name", cacheName: nil)
//        do{
//
//            floorObj = try context.fetch(request)
//            for floor in floorObj{
//                print(floor.rawRooms)
//            }
//        }catch{
//
//        }
////
//
//
//    }
    
}

