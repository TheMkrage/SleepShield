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
           l.text = "Phase"
           l.textColor = .white
           l.textAlignment = .center
           return l
       }()
    
    lazy var ageWeightCard: UIView = {
        let v = UIView()
        v.addSubview(ageWeightInfoLabel)
        v.addSubview(ageWeightStack)
        return v
    }()
    
    let ageWeightInfoLabel: Label = {
        let l = Label()
        l.text = "Please enter your age and weight"
        l.font = l.font.withSize(24.0)
        return l
    }()
    
    lazy var ageStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [ageLabel, ageField])
        return s
    }()
    let ageLabel: Label = {
        let l = Label()
        l.text = "Age"
        l.font = l.font.withSize(45.0)
        return l
    }()
    let ageField: UITextField = {
        let t = UITextField()
        t.font = UIFont(name: "proximanova-light", size: 55.0)
        t.borderStyle = .none
        t.backgroundColor = .none
        t.textColor = .white
        
        return t
    }()
    
    lazy var weightStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [weightLabel, weightField])
        return s
    }()
    let weightLabel: Label = {
        let l = Label()
        l.text = "Weight"
        l.font = l.font.withSize(45.0)
        return l
    }()
    let weightField: UITextField = {
        let t = UITextField()
        t.font = UIFont(name: "proximanova-light", size: 55.0)
        t.borderStyle = .none
        t.backgroundColor = .none
        t.textColor = .white
        
        return t
    }()
    
    lazy var ageWeightStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [ageStack, weightStack])
        
        return s
    }()
    
    // MARK - Caffeine Melatonin
    
    let caffeineMelatoninInfoLabel: Label = {
        let l = Label()
        l.text = "Do you use Caffeine or Melatonin?"
        l.font = l.font.withSize(24.0)
        return l
    }()
    
    let caffeineStack: UIStackView = {
        let image = UIImageView(image: .init(imageLiteralResourceName: "caffeine"))
        image.widthAnchor == 90
        image.heightAnchor == 83
        
        let label = Label()
        label.font = label.font.withSize(30)
        
        let switcher = UISwitch()
        
        
        let l = UIStackView(arrangedSubviews: [image, label, switcher])
        l.axis = .vertical
        l.spacing = 8.0
        
        return l
    }()
    
    let melatoninStack: UIStackView = {
        let image = UIImageView(image: .init(imageLiteralResourceName: "caffeine"))
        image.widthAnchor == 90
        image.heightAnchor == 83
        
        let label = Label()
        label.font = label.font.withSize(30)
        
        let switcher = UISwitch()
        
        
        let l = UIStackView(arrangedSubviews: [image, label, switcher])
        l.axis = .vertical
        l.spacing = 8.0
        
        return l
    }()
    
    lazy var melatoninCaffeineStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [caffeineStack, melatoninStack])
        s.axis = .horizontal
        s.spacing = 25
        
        return s
    }()
    
    lazy var caffeineMelatoninCard: UIView = {
        let v = UIView()
        v.addSubview(caffeineMelatoninInfoLabel)
        
        
        v.addSubview(melatoninCaffeineStack)
        return v
    }()
    
    let button = Button()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.init(named: "dark")
        
        view.addSubview(titleLabel)
        
        view.addSubview(ageWeightCard)
        view.addSubview(caffeineMelatoninCard)
        
        view.addSubview(button)
        
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.topAnchor == view.safeAreaLayoutGuide.topAnchor + 50
        titleLabel.centerXAnchor == view.centerXAnchor
        
        
        // Age Weight Card
        ageWeightCard.centerXAnchor == view.centerXAnchor
        ageWeightCard.topAnchor == titleLabel.bottomAnchor + 20
        ageWeightCard.leadingAnchor == view.leadingAnchor + 20
        ageWeightCard.trailingAnchor == view.trailingAnchor - 20
        
        ageWeightInfoLabel.leadingAnchor == ageWeightCard.leadingAnchor + 17
        ageWeightInfoLabel.trailingAnchor == ageWeightCard.trailingAnchor - 16
        ageWeightInfoLabel.topAnchor == ageWeightCard.topAnchor + 17
        
        ageWeightStack.topAnchor == ageWeightInfoLabel.bottomAnchor + 13
        ageWeightStack.leadingAnchor == ageWeightCard.leadingAnchor + 17
        ageWeightStack.trailingAnchor == ageWeightCard.trailingAnchor - 13
        ageWeightStack.bottomAnchor == ageWeightCard.bottomAnchor - 22
        
        
        // Caffeine Melatonin Card
        caffeineMelatoninCard.centerXAnchor == view.centerXAnchor
        caffeineMelatoninCard.topAnchor == ageWeightCard.bottomAnchor + 44
        caffeineMelatoninCard.leadingAnchor == view.leadingAnchor + 20
        caffeineMelatoninCard.trailingAnchor == view.trailingAnchor - 20
        
        caffeineMelatoninInfoLabel.leadingAnchor == caffeineMelatoninCard.leadingAnchor + 17
        caffeineMelatoninInfoLabel.trailingAnchor == caffeineMelatoninCard.trailingAnchor - 16
        caffeineMelatoninInfoLabel.topAnchor == caffeineMelatoninCard.topAnchor + 17
        
        melatoninCaffeineStack.topAnchor == caffeineMelatoninInfoLabel.bottomAnchor + 22
        melatoninCaffeineStack.leadingAnchor == caffeineMelatoninCard.leadingAnchor + 20
        melatoninCaffeineStack.trailingAnchor == caffeineMelatoninCard.trailingAnchor - 15
        melatoninCaffeineStack.bottomAnchor == caffeineMelatoninCard.bottomAnchor - 22
        
        
        //Button
        button.centerXAnchor == view.centerXAnchor
        button.topAnchor == melatoninCaffeineStack.bottomAnchor + 30
        button.heightAnchor == 60
        button.widthAnchor == 174
    }
}
