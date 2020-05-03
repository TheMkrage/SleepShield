//
//  WakeSlider.swift
//  SleepShield
//
//  Created by Matthew Krager on 5/2/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

//
//  CoolSlider.swift
//  SleepShield
//
//  Created by Matthew Krager on 5/2/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit

class WarmSlider: UISlider {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        layer.cornerRadius = 0
        setThumbImage(UIImage.init(named: "thumb"), for: .normal)
        
        let tgl = CAGradientLayer()
        let frame = CGRect.init(x:0, y:0, width: self.frame.size.width, height:5)
        tgl.frame = frame
        tgl.colors = [
            UIColor.init(hexString: "F57F17").cgColor,
            UIColor.init(hexString: "FFF176").cgColor,
            UIColor.init(hexString: "81D4FA").cgColor
        ]
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

