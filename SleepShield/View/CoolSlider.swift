//
//  CoolSlider.swift
//  SleepShield
//
//  Created by Matthew Krager on 5/2/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit

class CoolSlider: UISlider {
    
    init(colors: [CGColor]) {
        super.init(frame: .zero)
        initialize(colors: colors)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize(colors: [CGColor]) {
        layer.cornerRadius = 0
        setThumbImage(UIImage.init(named: "thumb"), for: .normal)
        
        let tgl = CAGradientLayer()
        let frame = CGRect.init(x:0, y:0, width: self.frame.size.width, height:5)
        tgl.frame = frame
        tgl.colors = colors
        tgl.startPoint = CGPoint.init(x:0.0, y:0.5)
        tgl.endPoint = CGPoint.init(x:1.0, y:0.5)

        UIGraphicsBeginImageContextWithOptions(tgl.frame.size, tgl.isOpaque, 0.0);
        tgl.render(in: UIGraphicsGetCurrentContext()!)
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()

            image.resizableImage(withCapInsets: UIEdgeInsets.zero)

            self.setMinimumTrackImage(image, for: .normal)
        }
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.trackRect(forBounds: bounds)
        rect.size.height = 35
        return rect
    }

}
