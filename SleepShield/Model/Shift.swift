//
//  Shift.swift
//  SleepShield
//
//  Created by Matthew Krager on 5/2/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit

class Shift: NSObject, Codable {
    var startTime: Date
    var endTime: Date
    
    var startDay: Date
    var endDay: Date
    
    init(startTime: Date, endTime: Date, startDay: Date, endDay: Date) {
        self.startTime = startTime
        self.endTime = endTime
        self.startDay = startDay
        self.endDay = endDay
    }
}
