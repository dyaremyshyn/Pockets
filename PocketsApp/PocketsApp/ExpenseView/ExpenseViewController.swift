//
//  ExpenseViewController.swift
//  PocketsApp
//
//  Created by User on 16/12/2022.
//

import UIKit

final class ExpenseViewController: UIViewController {
    var selectedExpenseType: DataModel.ExpensesType?
    
    lazy var titleTextField: PocketsTextFieldView = {
        let view = PocketsTextFieldView(title: "Title Expense")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var descriptionTextField: PocketsTextFieldView = {
        let view = PocketsTextFieldView(title: "Description Expense")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var amountTextField: PocketsTextFieldView = {
        let view = PocketsTextFieldView(title: "Expense Amount", keyboardType: .numbersAndPunctuation)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var expensePicker: UIPickerView = {
        let view = UIPickerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private lazy var saveButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setTitle("Save", for: .normal)
        view.setTitleColor(.blue, for: .normal)
        view.addTarget(self, action: #selector(saveExpense), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
    }
    
    func createView() {
        view.backgroundColor = .white
        view.addSubview(titleTextField)
        view.addSubview(descriptionTextField)
        view.addSubview(amountTextField)
        view.addSubview(expensePicker)
        view.addSubview(saveButton)
        
        let safeArea = view.safeAreaLayoutGuide
        titleTextField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20).isActive = true
        titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        
        descriptionTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10).isActive = true
        descriptionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        descriptionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        
        amountTextField.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 10).isActive = true
        amountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        amountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        
        expensePicker.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 10).isActive = true
        expensePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        expensePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        
        saveButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc func dismissPicker() {
        
    }
    
    @objc func saveExpense() {
        guard let type = selectedExpenseType, let amount = amountTextField.textField.text else { return }
        let model = DataModel(
            type: type,
            title: titleTextField.textField.text ?? "",
            description: descriptionTextField.textField.text ?? "",
            amount: Float(amount.replacingOccurrences(of: ",", with: ".")) ?? 0.0,
            date: Date()
        )
        
        print("Will save: \n \(model)")
    }
}

extension ExpenseViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let title = DataModel.ExpensesType.allCases.first { $0.rawValue == row }
        return title?.pickerTitle
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedExpenseType = DataModel.ExpensesType(rawValue: component)
    }
}

extension ExpenseViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        DataModel.ExpensesType.allCases.count
    }
}
