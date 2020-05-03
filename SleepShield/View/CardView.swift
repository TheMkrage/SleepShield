//
//  WhiteCardView.swift
//  LAHacks 2020
//
//  Created by Matthew Krager on 3/28/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    private var shadowLayer = CAShapeLayer()
    private var gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addDropShadow()
        self.setGradientBackground(colorTop: UIColor.init(hexString: "072863"), colorBottom: UIColor.init(hexString: "284679"))
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
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.cornerRadius = 10
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.8, y: 0.8)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds

        layer.insertSublayer(gradientLayer, at: 1)
    }
}
