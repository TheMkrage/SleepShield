//
//  AlgorithmInput.swift
//  SleepShield
//
//  Created by Matthew Krager on 5/2/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit

class AlgorithmInput: Encodable {

    var hasCaffeine = false
    var hasMelatonin = false
    var age = 25
    var weight = 150.0
    
    var lastSleep = Date()
    var lastWake = Date()
    
    var shifts: [Shift] = []
}
