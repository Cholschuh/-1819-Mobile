//
//  RoomsMO+CoreDataClass.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 2/18/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//
//

import Foundation
import CoreData

@objc(RoomsMO)
public class RoomsMO: NSManagedObject {
    var photos: [PhotosMO]? {
        return self.rawPhotos?.array as? [PhotosMO]
    }
}
