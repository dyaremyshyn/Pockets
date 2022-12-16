//
//  PocketsTextFieldView.swift
//  PocketsApp
//
//  Created by User on 16/12/2022.
//

import UIKit

final class PocketsTextFieldView: UIView {
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 17, weight: .bold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var textField: UITextField = {
        let view = UITextField()
        view.font = .systemFont(ofSize: 15, weight: .regular)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .opaqueSeparator
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        view.leftViewMode = .always
        return view
    }()
    
    init(title: String, text: String = "", keyboardType: UIKeyboardType = .default) {
        super.init(frame: .zero)
        titleLabel.text = title
        textField.text = text
        textField.keyboardType = keyboardType
        createView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createView() {
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 5
        addSubview(titleLabel)
        addSubview(textField)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
        
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
    }
}
