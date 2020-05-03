//
//  ShiftViewController.swift
//  SleepShield
//
//  Created by Matthew Krager on 5/2/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit
import Anchorage

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
        return b
    }()
    
    let table = UITableView()
    
    let button: Button = {
        let b = Button()
        b.setTitle("Next", for: .normal)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(titleLabel)
        view.addSubview(infoLabel)
        view.addSubview(createShiftButton)
        view.addSubview(table)
        view.addSubview(button)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.topAnchor == view.safeAreaLayoutGuide.topAnchor + 25
        titleLabel.centerXAnchor == view.centerXAnchor
        
        infoLabel.topAnchor == titleLabel.bottomAnchor + 4.0
        infoLabel.leadingAnchor == view.leadingAnchor + 40
        infoLabel.trailingAnchor == view.trailingAnchor - 40
        
        createShiftButton.topAnchor == infoLabel.bottomAnchor + 20
        createShiftButton.centerXAnchor == view.centerXAnchor
        createShiftButton.heightAnchor == 60
        createShiftButton.widthAnchor == 260
        
        table.topAnchor == createShiftButton.bottomAnchor + 20
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
