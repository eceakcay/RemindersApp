//
//  BaseReminderViewController.swift
//  RemindersApp
//
//  Created by Ece Akcay on 16.09.2025.
//

import Foundation
import UIKit
import SnapKit

class BaseReminderViewController : UIViewController {
    let titleTextView = CustomTextView(placeholder: "Title")
    let descriptionTextView = CustomTextView(placeholder: "Description")
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    let cancelButton = UIButton(type: .system)
    let actionButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(titleTextView)
        titleTextView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        view.addSubview(descriptionTextView)
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(100)
        }
        datePicker.datePickerMode = .date
        timePicker.preferredDatePickerStyle = .wheels
        view.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
        
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        view.addSubview(timePicker)
        timePicker.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(timePicker.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(44)
        }
        
        actionButton.setTitle("Done", for: .normal)
        view.addSubview(actionButton)
        actionButton.snp.makeConstraints { make in
            make.top.equalTo(timePicker.snp.bottom).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(44)
        }
    }
    
    @objc func cancelTapped() {
            navigationController?.popViewController(animated: true)
        }
}

