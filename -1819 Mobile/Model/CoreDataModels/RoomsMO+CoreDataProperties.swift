//
//  RoomsMO+CoreDataProperties.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 2/18/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//
//

import Foundation
import CoreData


extension RoomsMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RoomsMO> {
        return NSFetchRequest<RoomsMO>(entityName: "RoomsMO")
    }

    @NSManaged public var beaconMajorVal: String?
    @NSManaged public var beaconMinorVal: String?
    @NSManaged public var information: String?
    @NSManaged public var name: String?
    @NSManaged public var roomNumber: String?
    @NSManaged public var floor: FloorsMO?
    @NSManaged public var rawPhotos: NSOrderedSet?

}

// MARK: Generated accessors for rawPhotos
extension RoomsMO {

    @objc(insertObject:inRawPhotosAtIndex:)
    @NSManaged public func insertIntoRawPhotos(_ value: PhotosMO, at idx: Int)

    @objc(removeObjectFromRawPhotosAtIndex:)
    @NSManaged public func removeFromRawPhotos(at idx: Int)

    @objc(insertRawPhotos:atIndexes:)
    @NSManaged public func insertIntoRawPhotos(_ values: [PhotosMO], at indexes: NSIndexSet)

    @objc(removeRawPhotosAtIndexes:)
    @NSManaged public func removeFromRawPhotos(at indexes: NSIndexSet)

    @objc(replaceObjectInRawPhotosAtIndex:withObject:)
    @NSManaged public func replaceRawPhotos(at idx: Int, with value: PhotosMO)

    @objc(replaceRawPhotosAtIndexes:withRawPhotos:)
    @NSManaged public func replaceRawPhotos(at indexes: NSIndexSet, with values: [PhotosMO])

    @objc(addRawPhotosObject:)
    @NSManaged public func addToRawPhotos(_ value: PhotosMO)

    @objc(removeRawPhotosObject:)
    @NSManaged public func removeFromRawPhotos(_ value: PhotosMO)

    @objc(addRawPhotos:)
    @NSManaged public func addToRawPhotos(_ values: NSOrderedSet)

    @objc(removeRawPhotos:)
    @NSManaged public func removeFromRawPhotos(_ values: NSOrderedSet)

}
