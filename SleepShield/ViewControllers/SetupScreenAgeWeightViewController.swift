//
//  SetupScreenAgeWeightViewController.swift
//  SleepShield
//
//  Created by Matthew Krager on 5/2/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit
import Anchorage

class SetupScreenAgeWeightViewController: UIViewController {

    let titleLabel: Label = {
           let l = Label()
           l.font = UIFont(name: "ModernSansLight", size: 85.0)
           l.text = "phase"
           l.textColor = .white
           l.textAlignment = .center
           return l
       }()
    
    lazy var ageWeightCard: CardView = {
        let v = CardView()
        
        let q = UIImageView(image: UIImage.init(named: "question"))
        q.widthAnchor == 15
        q.heightAnchor == 15
        
        v.addSubview(q)
        q.topAnchor == v.topAnchor + 10
        q.trailingAnchor == v.trailingAnchor - 10
        v.addSubview(ageWeightInfoLabel)
        v.addSubview(ageWeightStack)
        return v
    }()
    
    let ageWeightInfoLabel: Label = {
        let l = Label()
        l.text = "Please enter your age and weight"
        l.font = l.font.withSize(20.0)
        return l
    }()
    
    lazy var ageStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [ageLabel, ageField])
        return s
    }()
    let ageLabel: Label = {
        let l = Label()
        l.text = "Age"
        l.font = l.font.withSize(35.0)
        return l
    }()
    let ageField: UITextField = {
        let t = UITextField()
        t.font = UIFont(name: "proximanova-light", size: 55.0)
        t.borderStyle = .none
        t.backgroundColor = .none
        t.textColor = .white
        t.text = "22"
        t.widthAnchor == 110
        t.textAlignment = .center
        
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: 56.0, width: 110, height: 1.0)
        bottomLine.backgroundColor = UIColor.white.cgColor
        t.layer.addSublayer(bottomLine)
        
        return t
    }()
    
    lazy var weightStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [weightLabel, weightField])
        return s
    }()
    let weightLabel: Label = {
        let l = Label()
        l.text = "Weight"
        l.font = l.font.withSize(35.0)
        
        return l
    }()
    let weightField: UITextField = {
        let t = UITextField()
        t.textAlignment = .center
        t.font = UIFont(name: "proximanova-light", size: 55.0)
        t.borderStyle = .none
        t.backgroundColor = .none
        t.textColor = .white
        t.widthAnchor == 110
        t.text = "150"
        
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: 56.0, width: 110, height: 1.0)
        bottomLine.backgroundColor = UIColor.white.cgColor
        t.layer.addSublayer(bottomLine)
        
        return t
    }()
    
    lazy var ageWeightStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [ageStack, weightStack])
        s.axis = .vertical
        s.spacing = 20
        return s
    }()
    
    // MARK - Caffeine Melatonin
    
    let caffeineMelatoninInfoLabel: Label = {
        let l = Label()
        l.text = "Do you use Caffeine or Melatonin?"
        l.font = l.font.withSize(20.0)
        return l
    }()
    
    let caffeineSwitcher: UISwitch = {
        let s = UISwitch()
        return s
    }()
    
    lazy var caffeineStack: UIStackView = {
        let image = UIImageView(image: UIImage.init(named: "caffeine"))
        image.widthAnchor == 90
        image.heightAnchor == 83
        
        let label = Label()
        label.text = "Caffeine"
        label.font = label.font.withSize(30)
        
        let l = UIStackView(arrangedSubviews: [image, label, caffeineSwitcher])
        l.axis = .vertical
        l.alignment = .center
        l.spacing = 8.0
        
        return l
    }()
    
    let melatoninSwitcher: UISwitch = {
        let s = UISwitch()
        return s
    }()
    
    lazy var melatoninStack: UIStackView = {
        let image = UIImageView(image: UIImage.init(named: "melatonin"))
        image.widthAnchor == 90
        image.heightAnchor == 83
        
        let label = Label()
        label.text = "Melatonin"
        label.font = label.font.withSize(30)
        
        let l = UIStackView(arrangedSubviews: [image, label, melatoninSwitcher])
        l.axis = .vertical
        l.alignment = .center
        l.spacing = 8.0
        
        return l
    }()
    
    lazy var melatoninCaffeineStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [caffeineStack, melatoninStack])
        s.axis = .horizontal
        s.spacing = 25
        s.distribution = .equalSpacing
        
        return s
    }()
    
    lazy var caffeineMelatoninCard: CardView = {
        let v = CardView()
        
        v.layer.cornerRadius = 10
        
        let q = UIImageView(image: UIImage.init(named: "question"))
        q.widthAnchor == 15
        q.heightAnchor == 15
        v.addSubview(q)
        q.topAnchor == v.topAnchor + 10
        q.trailingAnchor == v.trailingAnchor - 10
        v.addSubview(caffeineMelatoninInfoLabel)
        v.addSubview(melatoninCaffeineStack)
        return v
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
        
        view.addSubview(titleLabel)
        
        view.addSubview(ageWeightCard)
        view.addSubview(caffeineMelatoninCard)
        
        view.addSubview(button)
        
        
        setupConstraints()
    }
    
    @objc func didPressNext() {
        let vc = SetupScreenSleepViewController()
        vc.modalPresentationStyle = .fullScreen
        let algorithmInput = AlgorithmInput()
        algorithmInput.hasCaffeine = caffeineSwitcher.isOn
        algorithmInput.hasMelatonin = melatoninSwitcher.isOn
        algorithmInput.age = Int(ageField.text ?? "") ?? 25
        algorithmInput.weight = Double(weightField.text ?? "") ?? 150
        vc.algorithmInput = algorithmInput
        show(vc, sender: self)
    }
    
    private func setupConstraints() {
        titleLabel.topAnchor == view.safeAreaLayoutGuide.topAnchor + 25
        titleLabel.centerXAnchor == view.centerXAnchor
        
        
        // Age Weight Card
        ageWeightCard.centerXAnchor == view.centerXAnchor
        ageWeightCard.topAnchor == titleLabel.bottomAnchor + 20
        ageWeightCard.leadingAnchor == view.leadingAnchor + 20
        ageWeightCard.trailingAnchor == view.trailingAnchor - 20
        
        ageWeightInfoLabel.leadingAnchor == ageWeightCard.leadingAnchor + 17
        ageWeightInfoLabel.trailingAnchor == ageWeightCard.trailingAnchor - 36
        ageWeightInfoLabel.topAnchor == ageWeightCard.topAnchor + 17
        
        ageWeightStack.topAnchor == ageWeightInfoLabel.bottomAnchor + 15
        ageWeightStack.leadingAnchor == ageWeightCard.leadingAnchor + 17
        ageWeightStack.trailingAnchor == ageWeightCard.trailingAnchor - 13
        ageWeightStack.bottomAnchor == ageWeightCard.bottomAnchor - 22
        
        
        // Caffeine Melatonin Card
        caffeineMelatoninCard.centerXAnchor == view.centerXAnchor
        caffeineMelatoninCard.topAnchor == ageWeightCard.bottomAnchor + 44
        caffeineMelatoninCard.leadingAnchor == view.leadingAnchor + 20
        caffeineMelatoninCard.trailingAnchor == view.trailingAnchor - 20
        
        caffeineMelatoninInfoLabel.leadingAnchor == caffeineMelatoninCard.leadingAnchor + 17
        caffeineMelatoninInfoLabel.trailingAnchor == caffeineMelatoninCard.trailingAnchor - 36
        caffeineMelatoninInfoLabel.topAnchor == caffeineMelatoninCard.topAnchor + 17
        
        melatoninCaffeineStack.topAnchor == caffeineMelatoninInfoLabel.bottomAnchor + 22
        melatoninCaffeineStack.leadingAnchor == caffeineMelatoninCard.leadingAnchor + 20
        melatoninCaffeineStack.trailingAnchor == caffeineMelatoninCard.trailingAnchor - 15
        melatoninCaffeineStack.bottomAnchor == caffeineMelatoninCard.bottomAnchor - 22
        
        
        //Button
        button.centerXAnchor == view.centerXAnchor
        button.topAnchor == caffeineMelatoninCard.bottomAnchor + 30
        button.heightAnchor == 60
        button.widthAnchor == 174
    }
}
