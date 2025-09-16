//
//  CustomTextView.swift
//  RemindersApp
//
//  Created by Ece Akcay on 16.09.2025.
//

import Foundation
import UIKit
import SnapKit

class CustomTextView : UIView {
    private let textView = UITextView()
    private let placeholderLabel = UILabel()
    
    var text:String? {
        get { textView.text }
        set { textView.text = newValue; placeholderLabel.isHidden = newValue != nil && !newValue!.isEmpty }
    }
    
    init(placeholder:String) {
        super.init(frame: .zero)
        setupUI(placeholder : placeholder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(placeholder: String) {
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 5
        textView.font = .systemFont(ofSize: 16)
        textView.delegate = self
        addSubview(textView)
        textView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.greaterThanOrEqualTo(40)
        }
        
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = .lightGray
        placeholderLabel.font = .systemFont(ofSize: 16)
        addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(8)
        }
    }
}
extension CustomTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
