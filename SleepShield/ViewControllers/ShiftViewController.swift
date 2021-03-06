//
//  ShiftViewController.swift
//  SleepShield
//
//  Created by Matthew Krager on 5/2/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit
import Anchorage
import SwiftEntryKit

class ShiftViewController: UIViewController {

    var algorithmInput: AlgorithmInput!
    
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
        l.text = "Please enter your scheduled shifts"
        l.font = l.font.withSize(24.0)
        l.textAlignment = .center
        return l
    }()
    
    let createShiftButton: Button = {
        let b = Button()
        b.setTitle("Create Shift", for: .normal)
        b.addTarget(self, action: #selector(addShift), for: .touchUpInside)
        return b
    }()
    
    let table = UITableView()
    
    let button: Button = {
        let b = Button()
        b.setTitle("Next", for: .normal)
        b.addTarget(self, action: #selector(didPressNext), for: .touchUpInside)
        return b
    }()
    
    var shifts = [Shift]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(named: "dark")
        
        table.isHidden = true
        table.backgroundColor = UIColor.init(named: "light")
        table.layer.cornerRadius = 10
        table.register(ShiftTableViewCell.self, forCellReuseIdentifier: "shift")
        table.rowHeight = 70
        table.estimatedRowHeight = 70
        table.delegate = self
        table.dataSource = self
        
        
        view.addSubview(titleLabel)
        view.addSubview(infoLabel)
        view.addSubview(createShiftButton)
        view.addSubview(table)
        view.addSubview(button)
        
        setupConstraints()
    }
    
    @objc private func addShift() {
        let vc = AddShiftViewController()
        vc.delegate = self
        
        var attributes = EKAttributes()
        let widthConstraint = EKAttributes.PositionConstraints.Edge.ratio(value: 0.9)
        let heightConstraint = EKAttributes.PositionConstraints.Edge.ratio(value: 0.65)
        attributes.positionConstraints.size = .init(width: widthConstraint, height: heightConstraint)
        attributes.displayDuration = .infinity
        attributes.position = .center
        attributes.entryInteraction = .forward
        attributes.entryBackground = .visualEffect(style: .dark)
        SwiftEntryKit.display(entry: vc, using: attributes)
    }
    
    @objc func didPressNext() {
        let vc = ResultsViewController()
        vc.modalPresentationStyle = .fullScreen
        algorithmInput.shifts = shifts
        vc.algorithmInput = algorithmInput
        show(vc, sender: self)
    }
    
    private func setupConstraints() {
        titleLabel.topAnchor == view.safeAreaLayoutGuide.topAnchor + 20
        titleLabel.centerXAnchor == view.centerXAnchor
        
        infoLabel.topAnchor == titleLabel.bottomAnchor + 14.0
        infoLabel.leadingAnchor == view.leadingAnchor + 40
        infoLabel.trailingAnchor == view.trailingAnchor - 40
        
        createShiftButton.topAnchor == infoLabel.bottomAnchor + 28
        createShiftButton.centerXAnchor == view.centerXAnchor
        createShiftButton.heightAnchor == 60
        createShiftButton.widthAnchor == 260
        
        table.topAnchor == createShiftButton.bottomAnchor + 29
        table.leadingAnchor == view.leadingAnchor + 20
        table.trailingAnchor == view.trailingAnchor - 20
        
        //Button
        button.topAnchor == table.bottomAnchor + 20
        button.centerXAnchor == view.centerXAnchor
        button.bottomAnchor == view.safeAreaLayoutGuide.bottomAnchor - 20
        button.heightAnchor == 60
        button.widthAnchor == 174
    }
}

extension ShiftViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shifts.count
    }
    
    private func getMonthDay(date: Date) -> String {
        let format = DateFormatter()
        format.dateFormat = "MM/dd"
        return format.string(from: date)
    }
    private func getTime(date: Date) -> String {
        let format = DateFormatter()
        format.dateFormat = "hh:mm a"
        return format.string(from: date)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shift") as! ShiftTableViewCell
        let shift = shifts[indexPath.row]
        
        cell.datesLabel.text = getMonthDay(date: shift.startDay) + " - " + getMonthDay(date: shift.endDay)
        cell.timesLabel.text = getTime(date: shift.startTime) + " - " + getTime(date: shift.endTime)
        cell.shiftLabel.text = "Shift \(indexPath.row + 1)"
        
        return cell
    }
}

extension ShiftViewController: AddShiftViewControllerDelegate {
    func added(shift: Shift) {
        shifts.append(shift)
        table.isHidden = false
        table.reloadData()
    }
}
