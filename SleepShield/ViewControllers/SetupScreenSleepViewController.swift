//
//  SetupScreenSleepViewController.swift
//  SleepShield
//
//  Created by Matthew Krager on 5/2/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit
import Anchorage

class SetupScreenSleepViewController: UIViewController {

    var algorithmInput: AlgorithmInput!
    
    let titleLabel: Label = {
              let l = Label()
              l.font = UIFont(name: "ModernSansLight", size: 85.0)
              l.text = "Phase"
              l.textColor = .white
              l.textAlignment = .center
              return l
          }()
    
    var titleWakeStack: UIStackView = {
        let icon = UIImageView(image: UIImage.init(named: "sun"))
        let l = Label()
               l.font = l.font.withSize(35.0)
               l.text = "Wake"
        let s = UIStackView(arrangedSubviews: [icon, l])
        return s
    }()
    
    var wakeSlider: CoolSlider = {
        let c = CoolSlider()
        
        return c
    }()
    
    lazy var wakeCard: CardView = {
        let c = CardView()
        c.addSubview(titleWakeStack)
        c.addSubview(wakeSlider)
        
        return c
    }()
    
    // Sleep Card
    
    var titleSleepStack: UIStackView = {
        let icon = UIImageView(image: UIImage.init(named: "moon"))
        let l = Label()
               l.font = l.font.withSize(35.0)
               l.text = "Sleep"
        let s = UIStackView(arrangedSubviews: [icon, l])
        return s
    }()
    
    var sleepCard: CardView = {
        let c = CardView()
        
        return c
    }()
    let button: Button = {
        let b = Button()
        b.setTitle("Next", for: .normal)
        b.addTarget(self, action: #selector(didPressNext), for: .touchUpInside)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.init(named: "dark")
        
        view.addSubview(wakeCard)
        view.addSubview(sleepCard)
        
        view.addSubview(button)
        
        setupConstraints()
    }
    
    @objc func didPressNext() {
        let vc = ShiftViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.algorithmInput = algorithmInput
        show(vc, sender: self)
    }
    
    private func setupConstraints() {
        button.centerXAnchor == view.centerXAnchor
        button.bottomAnchor == view.safeAreaLayoutGuide.bottomAnchor - 20
        button.heightAnchor == 60
        button.widthAnchor == 174
        
        
    }
}
