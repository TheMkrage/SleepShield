//
//  TextField.swift
//  SleepShield
//
//  Created by Matthew Krager on 5/2/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit

class TextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        backgroundColor = UIColor.init(hexString: "6a7a96")
        layer.cornerRadius = 2.0
        textColor = .white
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 0.0))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 0.0))
    }
}
