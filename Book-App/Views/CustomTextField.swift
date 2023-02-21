//
//  CustomTextField.swift
//  Book-App
//
//  Created by Akın Çetin on 22.02.2023.
//

import UIKit

class CustomTextField: UITextField {

    let placeholderText: String
    
    init(placeholderText: String) {
        self.placeholderText = placeholderText
        super.init(frame: .zero)
        placeholder = placeholderText
        layer.cornerRadius = 8
        backgroundColor = .lightGray
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 50)
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)
    }
    
}
