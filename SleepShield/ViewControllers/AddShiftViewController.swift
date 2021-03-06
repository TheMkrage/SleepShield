//
//  AddShiftViewController.swift
//  SleepShield
//
//  Created by Matthew Krager on 5/2/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit
import Anchorage
import SwiftEntryKit

protocol AddShiftViewControllerDelegate {
    func added(shift: Shift)
}

class AddShiftViewController: UIViewController {
    
    var delegate: AddShiftViewControllerDelegate?
    
    let titleLabel: Label = {
        let l = Label()
        l.font = UIFont(name: "ModernSansLight", size: 50.0)
        l.text = "Add a Shift"
        l.textColor = .white
        l.textAlignment = .center
        return l
    }()
    
    var startTimePicker: UIDatePicker = {
        let d = UIDatePicker()
        d.datePickerMode = .time
        d.addTarget(self, action: #selector(startTimeSet), for: .valueChanged)
        return d
    }()
    
    var endTimePicker: UIDatePicker = {
        let d = UIDatePicker()
        d.addTarget(self, action: #selector(endTimeSet), for: .valueChanged)
        d.datePickerMode = .time
        return d
    }()
    
    var startDatePicker: UIDatePicker = {
        let d = UIDatePicker()
        d.addTarget(self, action: #selector(startDateSet), for: .valueChanged)
        d.datePickerMode = .date
        return d
    }()
    
    var endDatePicker: UIDatePicker = {
        let d = UIDatePicker()
        d.addTarget(self, action: #selector(endDateSet), for: .valueChanged)
        d.datePickerMode = .date
        return d
    }()
    
    lazy var startTimeLabel: Label = {
        let s = Label()
        s.font = s.font.withSize(25.0)
        s.text = "Start Time"
        return s
    }()
    lazy var endTimeLabel: Label = {
        let s = Label()
        s.font = s.font.withSize(25.0)
        s.text = "End Time"
        return s
    }()
    lazy var startDateLabel: Label = {
        let s = Label()
        s.font = s.font.withSize(25.0)
        s.text = "Start Date"
        return s
    }()
    lazy var endDateLabel: Label = {
        let s = Label()
        s.font = s.font.withSize(25.0)
        s.text = "End Date"
        return s
    }()
    
    lazy var startTimeField: TextField = {
        let s = TextField()
        s.inputView = startTimePicker
        s.text = getTime(date: startTimePicker.date)
        s.font = s.font?.withSize(20.0)
        return s
    }()
    lazy var endTimeField: TextField = {
        let s = TextField()
        s.inputView = endTimePicker
        s.text = getTime(date: endTimePicker.date)
        s.font = s.font?.withSize(20.0)
        return s
    }()
    lazy var startDateField: TextField = {
        let s = TextField()
        s.inputView = startDatePicker
        s.text = getMonthDay(date: startDatePicker.date)
        s.font = s.font?.withSize(20.0)
        return s
    }()
    lazy var endDateField: TextField = {
        let s = TextField()
        s.inputView = endDatePicker
        s.text = getMonthDay(date: endDatePicker.date)
        s.font = s.font?.withSize(20.0)
        return s
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func startTimeSet() {
        startTimeField.text = getTime(date: startTimePicker.date)
    }
    @objc func endTimeSet() {
        endTimeField.text = getTime(date: endTimePicker.date)
    }
    @objc func startDateSet() {
        startDateField.text = getMonthDay(date: startDatePicker.date)
    }
    @objc func endDateSet() {
        endDateField.text = getMonthDay(date: endDatePicker.date)
    }
    
    let button: Button = {
        let b = Button()
        b.setTitle("Add Shift", for: .normal)
        b.addTarget(self, action: #selector(didPressNext), for: .touchUpInside)
        return b
    }()
    
    
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
    
    @objc func didPressNext() {
        let shift = Shift(startTime: startTimePicker.date, endTime: endTimePicker.date, startDay: startDatePicker.date, endDay: endDatePicker.date)
        delegate?.added(shift: shift)
        SwiftEntryKit.dismiss()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.backgroundColor = UIColor.init(named: "light")
        view.layer.cornerRadius = 11.0
        //view
        
        view.addSubview(titleLabel)
        
        view.addSubview(startTimeLabel)
        view.addSubview(endTimeLabel)
        view.addSubview(startDateLabel)
        view.addSubview(endDateLabel)
        
        view.addSubview(startTimeField)
        view.addSubview(endTimeField)
        view.addSubview(startDateField)
        view.addSubview(endDateField)
        
        view.addSubview(button)
        
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setGradientBackground(colorTop: UIColor.init(hexString: "072863"), colorBottom: UIColor.init(hexString: "284679"))
    }
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.cornerRadius = 10
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.8, y: 0.8)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = view.bounds

        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupConstraints() {
        titleLabel.topAnchor == view.safeAreaLayoutGuide.topAnchor + 25
        titleLabel.centerXAnchor == view.centerXAnchor
        
        startTimeLabel.topAnchor == titleLabel.bottomAnchor + 37
        startTimeLabel.leadingAnchor == view.leadingAnchor + 15
        
        startTimeField.topAnchor == startTimeLabel.bottomAnchor
        startTimeField.leadingAnchor == startTimeLabel.leadingAnchor
        startTimeField.trailingAnchor == view.trailingAnchor - 15
        startTimeField.heightAnchor == 38
        
        
        endTimeLabel.topAnchor == startTimeField.bottomAnchor + 7
        endTimeLabel.leadingAnchor == startTimeLabel.leadingAnchor
        
        endTimeField.topAnchor == endTimeLabel.bottomAnchor
        endTimeField.leadingAnchor == startTimeLabel.leadingAnchor
        endTimeField.trailingAnchor == view.trailingAnchor - 15
        endTimeField.heightAnchor == 38
        
        
        startDateLabel.topAnchor == endTimeField.bottomAnchor + 15
        startDateLabel.leadingAnchor == startTimeLabel.leadingAnchor
        
        startDateField.topAnchor == startDateLabel.bottomAnchor
        startDateField.leadingAnchor == startTimeLabel.leadingAnchor
        startDateField.trailingAnchor == view.trailingAnchor - 15
        startDateField.heightAnchor == 38
        
        
        endDateLabel.topAnchor == startDateField.bottomAnchor + 7
        endDateLabel.leadingAnchor == startTimeLabel.leadingAnchor
        
        endDateField.topAnchor == endDateLabel.bottomAnchor
        endDateField.leadingAnchor == startTimeLabel.leadingAnchor
        endDateField.trailingAnchor == view.trailingAnchor - 15
        endDateField.heightAnchor == 38
        
        
        button.bottomAnchor == view.bottomAnchor - 15
        button.centerXAnchor == view.centerXAnchor
        button.widthAnchor == 250
        button.heightAnchor == 64
    }
}
