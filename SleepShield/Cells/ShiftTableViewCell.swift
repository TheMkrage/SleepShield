//
//  ShiftTableViewCell.swift
//  SleepShield
//
//  Created by Matthew Krager on 5/2/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit
import Anchorage

class ShiftTableViewCell: UITableViewCell {
    
    var didSetConstraints = false
    
    let shiftLabel: Label = {
        let l = Label()
        l.font = l.font.withSize(30.0)
        return l
    }()
    
    let timesLabel: Label = {
        let l = Label()
        l.font = l.font.withSize(24.0)
        return l
    }()
    
    let datesLabel: Label = {
        let l = Label()
        l.font = l.font.withSize(24.0)
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(shiftLabel)
        addSubview(timesLabel)
        addSubview(datesLabel)
        
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        defer {
            super.updateConstraints()
        }
        guard !didSetConstraints else {
            return
        }
        didSetConstraints = true
        
        shiftLabel.leadingAnchor == leadingAnchor + 10
        shiftLabel.centerYAnchor == centerYAnchor
        
        timesLabel.leadingAnchor == shiftLabel.trailingAnchor + 10
        timesLabel.centerYAnchor == centerYAnchor
        
        datesLabel.leadingAnchor == timesLabel.trailingAnchor + 20
        datesLabel.centerYAnchor == centerYAnchor
    }
}
