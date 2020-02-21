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
    
    enum CoreDataHelperError: Error {
        case fetchfailed
    }
    
    
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
    
    //Floors
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
    
    
    //Rooms
    
    class func getDetectedRoom (beaconMajorVal: String, beaconMinorVal: String) -> RoomsMO{
        let context = getContext()
        //var detectedRoom: RoomsMO
        var roomsResult : [RoomsMO] = []
        let fetchRequest: NSFetchRequest<RoomsMO> = RoomsMO.fetchRequest()
        let predicate1 = NSPredicate(format: "beaconMajorVal = %@", beaconMajorVal)
        let predicate2 = NSPredicate(format: "beaconMinorVal = %@", beaconMinorVal)
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2])
        do{
            roomsResult = try context.fetch(fetchRequest)
        }catch {
            print("Code not find room")
        }
        return roomsResult[0]
    }
    
    class func detectedRoomExist (beaconMajorVal: String, beaconMinorVal: String) -> Bool{
        let context = getContext()
        //var detectedRoom: RoomsMO
        var roomsResult : [RoomsMO] = []
        let fetchRequest: NSFetchRequest<RoomsMO> = RoomsMO.fetchRequest()
        let predicate1 = NSPredicate(format: "beaconMajorVal = %@", beaconMajorVal)
        let predicate2 = NSPredicate(format: "beaconMinorVal = %@", beaconMinorVal)
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2])
        do{
            roomsResult = try context.fetch(fetchRequest)
            if roomsResult.count > 0{
                return true
            }else{
                print("Results Empty")
            }
            
        }catch {
            print("Code not find room")
        }
        return false
    }
    
    class func getDetectedRoomWThrow (beaconMajorVal: String, beaconMinorVal: String) throws -> RoomsMO{
           let context = getContext()
           var detectedRoom: RoomsMO
           var roomsResult : [RoomsMO] = []
           let fetchRequest: NSFetchRequest<RoomsMO> = RoomsMO.fetchRequest()
           let predicate1 = NSPredicate(format: "beaconMajorVal = %@", beaconMajorVal)
           let predicate2 = NSPredicate(format: "beaconMinorVal = %@", beaconMinorVal)
           fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2])
           do{
               roomsResult = try context.fetch(fetchRequest)
           }catch {
            throw CoreDataHelperError.fetchfailed
           }
            detectedRoom = roomsResult[0]
            return detectedRoom
    }
}

