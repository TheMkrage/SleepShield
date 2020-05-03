//
//  Button.swift
//  SleepShield
//
//  Created by Matthew Krager on 5/2/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit

class Button: UIButton {
    
    private var shadowLayer = CAShapeLayer()
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addDropShadow()
    }
    
    func addDropShadow() {
        layer.masksToBounds = false
        shadowLayer.removeFromSuperlayer()
        
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
        shadowLayer.fillColor = UIColor.init(named: "light")?.cgColor

        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        shadowLayer.shadowOpacity = 0.25
        shadowLayer.shadowRadius = 10

        layer.insertSublayer(shadowLayer, at: 0)
    }
}
