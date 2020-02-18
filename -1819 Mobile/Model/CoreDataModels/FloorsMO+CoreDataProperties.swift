//
//  FloorsMO+CoreDataProperties.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 2/18/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//
//

import Foundation
import CoreData


extension FloorsMO {

    @nonobjc public class func createfetchRequest() -> NSFetchRequest<FloorsMO> {
        return NSFetchRequest<FloorsMO>(entityName: "FloorsMO")
    }

    @NSManaged public var mapImage: String?
    @NSManaged public var name: String?
    @NSManaged public var rawRooms: NSOrderedSet?

}

// MARK: Generated accessors for rawRooms
extension FloorsMO {

    @objc(insertObject:inRawRoomsAtIndex:)
    @NSManaged public func insertIntoRawRooms(_ value: RoomsMO, at idx: Int)

    @objc(removeObjectFromRawRoomsAtIndex:)
    @NSManaged public func removeFromRawRooms(at idx: Int)

    @objc(insertRawRooms:atIndexes:)
    @NSManaged public func insertIntoRawRooms(_ values: [RoomsMO], at indexes: NSIndexSet)

    @objc(removeRawRoomsAtIndexes:)
    @NSManaged public func removeFromRawRooms(at indexes: NSIndexSet)

    @objc(replaceObjectInRawRoomsAtIndex:withObject:)
    @NSManaged public func replaceRawRooms(at idx: Int, with value: RoomsMO)

    @objc(replaceRawRoomsAtIndexes:withRawRooms:)
    @NSManaged public func replaceRawRooms(at indexes: NSIndexSet, with values: [RoomsMO])

    @objc(addRawRoomsObject:)
    @NSManaged public func addToRawRooms(_ value: RoomsMO)

    @objc(removeRawRoomsObject:)
    @NSManaged public func removeFromRawRooms(_ value: RoomsMO)

    @objc(addRawRooms:)
    @NSManaged public func addToRawRooms(_ values: NSOrderedSet)

    @objc(removeRawRooms:)
    @NSManaged public func removeFromRawRooms(_ values: NSOrderedSet)

}
