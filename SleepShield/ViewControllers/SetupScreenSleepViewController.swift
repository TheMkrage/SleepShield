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
      l.text = "phase"
      l.textColor = .white
      l.textAlignment = .center
      return l
    }()
    
    var infoText: Label = {
        let l = Label()
        l.font = l.font.withSize(24.0)
        l.textAlignment = .center
        l.text = "Put in the time you woke up and slept last night"
        return l
    }()
    
    var titleWakeStack: UIStackView = {
        let icon = UIImageView(image: UIImage.init(named: "sun"))
        icon.widthAnchor == 40
        icon.heightAnchor == 40
        let l = Label()
               l.font = l.font.withSize(35.0)
               l.text = "Wake"
        l.widthAnchor == 90
        let s = UIStackView(arrangedSubviews: [icon, l])
        s.spacing = 15
        return s
    }()
    
    let wakeTimeLabel: Label = {
        let l = Label()
        l.text = "6:00 AM"
        return l
    }()
    
    var wakeSlider: WarmSlider = {
        let c = WarmSlider()
        c.addTarget(self, action: #selector(wakeDidChange), for: .valueChanged)
        return c
    }()
    
    lazy var wakeCard: CardView = {
        let c = CardView()
        
        let q = UIImageView(image: UIImage.init(named: "question"))
       q.widthAnchor == 15
       q.heightAnchor == 15
       c.addSubview(q)
       q.topAnchor == c.topAnchor + 10
       q.trailingAnchor == c.trailingAnchor - 10
        c.addSubview(titleWakeStack)
        c.addSubview(wakeTimeLabel)
        c.addSubview(wakeSlider)
        
        return c
    }()
    
    // Sleep Card
    
    var titleSleepStack: UIStackView = {
        let icon = UIImageView(image: UIImage.init(named: "moon"))
        icon.widthAnchor == 36
        icon.heightAnchor == 36
        let l = Label()
        l.font = l.font.withSize(35.0)
        l.text = "Sleep"
        l.widthAnchor == 90
        let s = UIStackView(arrangedSubviews: [icon, l])
        s.spacing = 15
        return s
    }()
    
    let sleepTimeLabel: Label = {
        let l = Label()
        l.text = "8:00 PM"
        return l
    }()
    
    var sleepSlider: CoolSlider = {
        let c = CoolSlider()
        c.addTarget(self, action: #selector(sleepDidChange), for: .valueChanged)
        return c
    }()
    
    lazy var sleepCard: CardView = {
        let c = CardView()
        let q = UIImageView(image: UIImage.init(named: "question"))
        q.widthAnchor == 15
        q.heightAnchor == 15
        c.addSubview(q)
        q.topAnchor == c.topAnchor + 10
        q.trailingAnchor == c.trailingAnchor - 10
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
        view.addSubview(infoText)
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
        let hour = Int(23 * val)
        
        let current = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        let currentHour24 = dateFormatter.string(from: current)
        
        let final = DateFormatter()
        final.dateFormat = "HH:mm, d MM y"
        
        let formatter4 = DateFormatter()
        formatter4.dateFormat = "d MM y"
        
        if Int(currentHour24)! > hour  {
            let todayString = formatter4.string(from: current)
            let s = "\(hour):00, \(todayString)"
            
            algorithmInput.lastWake = final.date(from: s)!
        } else {
            let dayComp = DateComponents(day: -1)
            let newcurrent = Calendar.current.date(byAdding: dayComp, to: current)!
            
            let todayString = formatter4.string(from: newcurrent)
            let s = "\(hour):00, \(todayString)"
            algorithmInput.lastWake = final.date(from: s)!
        }
        
        wakeTimeLabel.text = getTime(from: Float(hour))
    }
    
    @objc func sleepDidChange() {
        let val = sleepSlider.value
        let hour = Int(23 * val)
        
        let current = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        let currentHour24 = dateFormatter.string(from: current)
        
        let final = DateFormatter()
        final.dateFormat = "HH:mm, d MM y"
        
        let formatter4 = DateFormatter()
        formatter4.dateFormat = "d MM y"
        
        if Int(currentHour24)! > hour  {
            let todayString = formatter4.string(from: current)
            let s = "\(hour):00, \(todayString)"
            
            algorithmInput.lastSleep = final.date(from: s)!
        } else {
            let dayComp = DateComponents(day: -1)
            let newcurrent = Calendar.current.date(byAdding: dayComp, to: current)!
            
            let todayString = formatter4.string(from: newcurrent)
            let s = "\(hour):00, \(todayString)"
            algorithmInput.lastSleep = final.date(from: s)!
        }
        
        sleepTimeLabel.text = getTime(from: Float(hour))
    }
    
    private func setupConstraints() {
        titleLabel.topAnchor == view.safeAreaLayoutGuide.topAnchor + 25
        titleLabel.centerXAnchor == view.centerXAnchor
        
        infoText.topAnchor == titleLabel.bottomAnchor + 15
        infoText.centerXAnchor == view.centerXAnchor
        infoText.leadingAnchor == view.leadingAnchor + 20
        infoText.trailingAnchor == view.trailingAnchor - 20
        
        wakeCard.topAnchor == infoText.bottomAnchor + 45
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
        wakeSlider.bottomAnchor == wakeCard.bottomAnchor - 25
        
        // Sleep Card
        sleepCard.topAnchor == wakeCard.bottomAnchor + 25
        sleepCard.leadingAnchor == view.leadingAnchor + 20
        sleepCard.trailingAnchor == view.trailingAnchor - 20
        
        titleSleepStack.topAnchor == sleepCard.topAnchor + 8
        titleSleepStack.leadingAnchor == sleepCard.leadingAnchor + 12
        
        sleepTimeLabel.topAnchor == titleSleepStack.bottomAnchor + 20
        sleepTimeLabel.leadingAnchor == sleepCard.leadingAnchor + 25
        sleepTimeLabel.trailingAnchor == sleepCard.trailingAnchor - 25
        
        sleepSlider.topAnchor == sleepTimeLabel.bottomAnchor + 10
        sleepSlider.leadingAnchor == sleepCard.leadingAnchor + 25
        sleepSlider.trailingAnchor == sleepCard.trailingAnchor - 25
        sleepSlider.bottomAnchor == sleepCard.bottomAnchor - 25
        
        
        // button
        button.centerXAnchor == view.centerXAnchor
        button.bottomAnchor == view.safeAreaLayoutGuide.bottomAnchor - 20
        button.heightAnchor == 60
        button.widthAnchor == 174
    }
}
