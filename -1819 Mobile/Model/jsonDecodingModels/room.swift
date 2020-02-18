//
//  room.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 2/18/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//

import Foundation
struct room: Codable {
    var name: String
    var roomNumber: String
    var information: String
    var beaconMinorVal: String?
    var beaconMajorVal: String?
    var photos: [photo]
}
