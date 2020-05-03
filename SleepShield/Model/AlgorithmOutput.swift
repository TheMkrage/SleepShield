//
//  AlgorithmOutput.swift
//  SleepShield
//
//  Created by Matthew Krager on 5/2/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit

class Event: Codable {
    init(iconName: String, timeText: String, name: String, dosageText: String? = nil) {
        self.iconName = iconName
        self.timeText = timeText
        self.name = name
        self.dosageText = dosageText
    }
    
    var iconName: String
    var timeText: String
    var name: String
    var dosageText: String?
}

class Day: Codable {
    init(day: String, events: [Event]) {
        self.day = day
        self.events = events
    }
    
    var day: String
    var events: [Event]
}

class AlgorithmOutput: Codable {
    init(days: [Day]) {
        self.days = days
    }
    
    var days: [Day]
}
