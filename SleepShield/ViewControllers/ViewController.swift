//
//  ViewController.swift
//  SleepShield
//
//  Created by Matthew Krager on 5/2/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        let gradient = CAGradientLayer()

        gradient.frame = view.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.black.cgColor]

        view.layer.insertSublayer(gradient, at: 0)
    }


}

