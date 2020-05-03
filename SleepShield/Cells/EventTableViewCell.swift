//
//  EventTableViewCell.swift
//  SleepShield
//
//  Created by Matthew Krager on 5/2/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit
import Anchorage

class EventTableViewCell: UITableViewCell {
    
    var didSetConstraints = false
    
    lazy var card: CardView = {
        let c = CardView()
        c.addSubview(iconView)
        c.addSubview(timeLabel)
        c.addSubview(eventLabel)
        c.addSubview(dosageLabel)
        return c
    }()
    
    let iconView = UIImageView()
    let timeLabel: Label = {
        let l = Label()
        l.font = l.font.withSize(32.0)
        l.textAlignment = .right
        return l
    }()
    let eventLabel: Label = {
        let l = Label()
        l.font = l.font.withSize(28.0)
        return l
    }()
    let dosageLabel: Label = {
        let l = Label()
        l.font = l.font.withSize(28.0)
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
        
        contentView.addSubview(card)
        
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
        
        card.topAnchor == contentView.topAnchor + 10
        card.leadingAnchor == contentView.leadingAnchor + 20
        card.trailingAnchor == contentView.trailingAnchor - 20
        card.bottomAnchor == contentView.bottomAnchor - 10
        
        iconView.heightAnchor == 38
        iconView.widthAnchor == 38
        iconView.topAnchor == card.topAnchor + 12
        iconView.leadingAnchor == card.leadingAnchor + 12
        
        timeLabel.topAnchor == card.topAnchor + 12
        timeLabel.trailingAnchor == card.trailingAnchor - 12
        
        eventLabel.topAnchor == iconView.bottomAnchor + 12
        eventLabel.leadingAnchor == iconView.leadingAnchor
        //eventLabel.bottomAnchor == card.bottomAnchor - 12
        
        dosageLabel.trailingAnchor == card.trailingAnchor - 12
        dosageLabel.centerYAnchor == eventLabel.centerYAnchor
    }
}

