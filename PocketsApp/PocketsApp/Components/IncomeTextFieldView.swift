//
//  IncomeTextFieldView.swift
//  PocketsApp
//
//  Created by User on 07/12/2022.
//

import UIKit

class IncomeTextFieldView: UIView {
    public lazy var textField: UITextField = {
        let view = UITextField()
        view.font = .boldSystemFont(ofSize: 22)
        view.placeholder = "0€"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        view.leftViewMode = .always
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        createView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createView() {
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        
        self.addSubview(textField)
        
        textField.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        textField.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        textField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
    }
}
