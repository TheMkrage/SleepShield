//
//  ViewController.swift
//  SleepShield
//
//  Created by Matthew Krager on 5/2/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit
import Anchorage

class ViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont(name: "ModernSansLight", size: 85.0)
        l.text = "Phase"
        l.textColor = .white
        l.textAlignment = .center
        return l
    }()
    let button = Button()
    let gradientView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(named: "dark")
        
        button.addTarget(self, action: #selector(didPressNext), for: .touchUpInside)
        button.setTitle("Next", for: .normal)
        view.addSubview(gradientView)
        view.addSubview(button)
        view.addSubview(titleLabel)
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /*let gradient = CAGradientLayer()
        gradient.colors = [UIColor.init(named: "dark") ?? .black, UIColor.init(named: "light") ?? .white]
        gradient.startPoint = CGPoint(x: 0.0, y: 0)
        gradient.endPoint = CGPoint(x: 1.0, y: gradientView.bounds.height)
        gradient.locations = [0, 1]
        gradient.frame = gradientView.bounds
        
        //view.backgroundColor = .white
        gradientView.layer.insertSublayer(gradient, at: 0)*/
    }
    
    @objc func didPressNext() {
        let vc = SetupScreenAgeWeightViewController()
        vc.modalPresentationStyle = .fullScreen
        show(vc, sender: self)
    }
    
    private func setupConstraints() {
        titleLabel.topAnchor == view.topAnchor + 150
        titleLabel.centerXAnchor == view.centerXAnchor
        
        gradientView.edgeAnchors == view.edgeAnchors
        button.heightAnchor == 60
        button.widthAnchor == 174
        button.centerXAnchor == view.centerXAnchor
        button.bottomAnchor == view.safeAreaLayoutGuide.bottomAnchor - 30
    }
}
