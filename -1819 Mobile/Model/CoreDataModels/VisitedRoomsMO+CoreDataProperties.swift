//
//  VisitedRoomsMO+CoreDataProperties.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 2/15/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//
//

import Foundation
import CoreData


extension VisitedRoomsMO {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<VisitedRoomsMO> {
        return NSFetchRequest<VisitedRoomsMO>(entityName: "VisitedRoomsMO")
    }

    @NSManaged public var name: String?

}
