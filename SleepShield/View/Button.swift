//
//  Button.swift
//  SleepShield
//
//  Created by Matthew Krager on 5/2/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit

class Button: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        layer.cornerRadius = 10
        backgroundColor = UIColor.init(named: "buttonColor")
        setTitleColor(UIColor.white, for: .normal)
        titleLabel?.font = UIFont(name: "proximanova-light", size: 35.0)
    }
}
