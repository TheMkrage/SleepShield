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
    
    var infoText: Label = {
        let l = Label()
        l.text = "Put in the time you woke up and slept last night"
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
    
    let wakeTimeLabel: Label = {
        let l = Label()
        l.text = "6:00 AM"
        return l
    }()
    
    var wakeSlider: CoolSlider = {
        let c = CoolSlider(colors: [
            UIColor.init(hex: "#81D4FA")!.cgColor,
            UIColor.init(hex: "#FFF176")!.cgColor,
            UIColor.init(hex: "#F57F17")!.cgColor])
        c.addTarget(self, action: #selector(wakeDidChange), for: .valueChanged)
        return c
    }()
    
    lazy var wakeCard: CardView = {
        let c = CardView()
        c.addSubview(titleWakeStack)
        c.addSubview(wakeTimeLabel)
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
    
    let sleepTimeLabel: Label = {
        let l = Label()
        l.text = "8:00 PM"
        return l
    }()
    
    var sleepSlider: CoolSlider = {
        let c = CoolSlider(colors: [
        UIColor.init(hex: "#0E1449")!.cgColor,
        UIColor.init(hex: "#0D47A1")!.cgColor,
        UIColor.init(hex: "#2196F3")!.cgColor])
        
        return c
    }()
    
    lazy var sleepCard: CardView = {
        let c = CardView()
        c.addSubview(titleSleepStack)
        c.addSubview(sleepTimeLabel)
        c.addSubview(sleepSlider)
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
        
        view.addSubview(titleLabel)
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
    
    private func getTime(from hour: Float) -> String {
        let dateAsString = "\(Int(hour))"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        let date = dateFormatter.date(from: dateAsString)

        dateFormatter.dateFormat = "hh:mm a"
        let date12 = dateFormatter.string(from: date!)
        
        return date12
    }
    
    @objc func wakeDidChange() {
        let val = wakeSlider.value
        let hour = 23 * val
        wakeTimeLabel.text = getTime(from: hour)
    }
    
    @objc func sleepDidChange() {
        let val = sleepSlider.value
        let hour = 23.0 * val
        sleepTimeLabel.text = getTime(from: hour)
    }
    
    private func setupConstraints() {
        titleLabel.topAnchor == view.safeAreaLayoutGuide.topAnchor + 25
        titleLabel.centerXAnchor == view.centerXAnchor
        
        wakeCard.topAnchor == titleLabel.bottomAnchor + 25
        wakeCard.leadingAnchor == view.leadingAnchor + 20
        wakeCard.trailingAnchor == view.trailingAnchor - 20
        
        titleWakeStack.topAnchor == wakeCard.topAnchor + 8
        titleWakeStack.leadingAnchor == wakeCard.leadingAnchor + 12
        
        wakeTimeLabel.topAnchor == titleWakeStack.bottomAnchor + 20
        wakeTimeLabel.leadingAnchor == wakeCard.leadingAnchor + 25
        wakeTimeLabel.trailingAnchor == wakeCard.trailingAnchor - 25
        
        wakeSlider.topAnchor == wakeTimeLabel.bottomAnchor + 10
        wakeSlider.leadingAnchor == wakeCard.leadingAnchor + 25
        wakeSlider.trailingAnchor == wakeCard.trailingAnchor - 25
        wakeSlider.bottomAnchor == wakeCard.bottomAnchor - 15
        
        // Sleep Card
        sleepCard.topAnchor == wakeCard.bottomAnchor + 25
        sleepCard.leadingAnchor == view.leadingAnchor + 20
        sleepCard.trailingAnchor == view.trailingAnchor - 20
        
        titleSleepStack.topAnchor == sleepCard.topAnchor + 8
        titleSleepStack.leadingAnchor == sleepCard.leadingAnchor + 12
        
        button.centerXAnchor == view.centerXAnchor
        button.bottomAnchor == view.safeAreaLayoutGuide.bottomAnchor - 20
        button.heightAnchor == 60
        button.widthAnchor == 174
    }
}
