//
//  FloorsMO+CoreDataClass.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 2/18/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//
//

import Foundation
import CoreData

@objc(FloorsMO)
public class FloorsMO: NSManagedObject {
    var rooms: [RoomsMO]? {
        return self.rawRooms?.array as? [RoomsMO]
    }
}
