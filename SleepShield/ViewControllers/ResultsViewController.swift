//
//  ResultsViewController.swift
//  SleepShield
//
//  Created by Matthew Krager on 5/2/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import Anchorage
import UIKit

class ResultsViewController: UIViewController {
    
    var algorithmInput: AlgorithmInput!
    var algorithmOutput: AlgorithmOutput? = AlgorithmOutput(days: [
        Day(day: "5/2", events: [
            Event(iconName: "caffeine", timeText: "8:00 AM", name: "Drink Coffee", dosageText: "15mg"),
            Event(iconName: "melatonin", timeText: "8:00 AM", name: "Take Melatonin", dosageText: "16900mg"),
            Event(iconName: "sleep", timeText: "8:00 AM - 9:00 PM", name: "Sleep", dosageText: "15mg"),
            Event(iconName: "caffeine", timeText: "8:10 AM", name: "Take Caffeine", dosageText: "15mg")
            ]),
        Day(day: "5/3", events: [
            Event(iconName: "caffeine", timeText: "8:00 AM", name: "Drink Cofdasffee", dosageText: "15mg"),
            Event(iconName: "melatonin", timeText: "8:00 AM", name: "Take Melatonin", dosageText: "16900mg"),
            Event(iconName: "sleep", timeText: "8:00 AM - 9:00 PM", name: "Sleep", dosageText: "15mg"),
            Event(iconName: "caffeine", timeText: "8:10 AM", name: "Take Caffeine", dosageText: "15mg")
            ])
        ])
    var dayIndex = 0
    
    let titleLabel: Label = {
        let l = Label()
        l.font = UIFont(name: "ModernSansLight", size: 85.0)
        l.text = "phase"
        l.textColor = .white
        l.textAlignment = .center
        return l
    }()
    
    let infoLabel: Label = {
        let l = Label()
        l.font = l.font.withSize(24.0)
        l.text = "phase has a plan for you!"
        return l
    }()
    
    
    // Top component
    let leftArrow: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "left"), for: .normal)
        b.addTarget(self, action: #selector(leftPressed), for: .touchUpInside)
        return b
    }()
    
    let dayText: UILabel = {
        let l = Label()
        l.font = l.font.withSize(27.0)
        l.text = "Today"
        l.textAlignment = .center
        return l
    }()
    
    let rightArrow: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "right"), for: .normal)
        b.addTarget(self, action: #selector(rightPressed), for: .touchUpInside)
        return b
    }()
    
    lazy var topStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [leftArrow, dayText, rightArrow])
        s.axis = .horizontal
        return s
    }()
    
    // Table
    let table = UITableView()
    
    @objc func leftPressed() {
        if dayIndex == 0 {
            return
        }
        dayIndex -= 1
        table.reloadData()
        dayText.text = algorithmOutput?.days[dayIndex].day
    }
    
    @objc func rightPressed() {
        if dayIndex + 1 == algorithmOutput?.days.count ?? 1 {
            return
        }
        dayIndex += 1
        table.reloadData()
        dayText.text = algorithmOutput?.days[dayIndex].day
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        BackendCaller.shared.callAlgorithm(algorithmInput: algorithmInput) { (output) in
            self.algorithmOutput = output
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
        
        view.backgroundColor = UIColor.init(named: "dark")

        view.addSubview(titleLabel)
        view.addSubview(infoLabel)
        
        view.addSubview(topStack)
        
        table.register(EventTableViewCell.self, forCellReuseIdentifier: "event")
        table.rowHeight = 120.0
        table.estimatedRowHeight = 120.0
        table.backgroundColor = .clear
        table.delegate = self
        table.dataSource = self
        view.addSubview(table)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.topAnchor == view.safeAreaLayoutGuide.topAnchor + 25
        titleLabel.centerXAnchor == view.centerXAnchor
        
        infoLabel.topAnchor == titleLabel.bottomAnchor + 10
        infoLabel.centerXAnchor == view.centerXAnchor
        
        topStack.centerXAnchor == view.centerXAnchor
        topStack.topAnchor == infoLabel.bottomAnchor + 22
        
        table.topAnchor == topStack.bottomAnchor + 15
        table.leadingAnchor == view.leadingAnchor
        table.trailingAnchor == view.trailingAnchor
        table.bottomAnchor == view.safeAreaLayoutGuide.bottomAnchor
    }
}

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return algorithmOutput?.days[dayIndex].events.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "event") as! EventTableViewCell
        guard let event = algorithmOutput?.days[dayIndex].events[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.timeLabel.text = event.timeText
        cell.eventLabel.text = event.name
        cell.iconView.image = UIImage(named: event.iconName + "-icon")
        cell.dosageLabel.text = event.dosageText
        
        return cell
    }
    
     
}
