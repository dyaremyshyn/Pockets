//
//  CalculatorRuleViewController.swift
//  PocketsApp
//
//  Created by User on 07/12/2022.
//

import UIKit

final class CalculatorRuleViewController: UIViewController {
   // MARK: Vars and Components
    var selectedRule: Rule
    let textSize:CGFloat = 30
    let titleSize:CGFloat = 22
    
    private lazy var incomeTitle: UILabel = {
        return createTitle(text: "Monthly after-tax income")
    }()
    
    private lazy var incomeTextField: IncomeTextFieldView = {
        let view = IncomeTextFieldView()
        view.textField.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var necessitiesLabel: UILabel = {
        return createLabel()
    }()
    
    private lazy var wantsLabel: UILabel = {
        return createLabel()
    }()
    
    private lazy var savingsLabel: UILabel = {
        return createLabel()
    }()
    
    private lazy var necessitiesTitle: UILabel = {
        return createTitle(text: "NECESSITIES")
    }()
    
    private lazy var wantsTitle: UILabel = {
        return createTitle(text: "WANTS")
    }()
    
    private lazy var savingsTitle: UILabel = {
        return createTitle(text: "SAVINGS AND DEBT REPAYMENT")
    }()
    
    private lazy var necessitiesStackView: UIStackView = {
        return createStackView(views: [necessitiesTitle, necessitiesLabel])
    }()
    
    private lazy var wantsStackView: UIStackView = {
        return createStackView(views: [wantsTitle, wantsLabel])
    }()
    
    private lazy var savingsStackView: UIStackView = {
        return createStackView(views: [savingsTitle, savingsLabel])
    }()
    
    private lazy var incomeStackView: UIStackView = {
        return createStackView(views: [incomeTitle, incomeTextField])
    }()
    
    private lazy var mainStackView: UIStackView = {
        return createStackView(views: [
            incomeStackView,
            necessitiesStackView,
            wantsStackView,
            savingsStackView
        ], spacing: 25)
    }()
    
    private lazy var nextButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setTitle("Start", for: .normal)
        view.setTitleColor(.blue, for: .normal)
        view.addTarget(self, action: #selector(nextView), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // MARK: LifeCycle and Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
    }
    
    init(selectedRule: Rule) {
        self.selectedRule = selectedRule
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Selectors Funcs
    @objc func nextView() {
        // navigate to the next view, when user will append expenses
    }
    
    // MARK: CreateView
    func createLabel() -> UILabel {
        let view = UILabel()
        view.textColor = .blue
        view.text = "0€"
        view.font = .boldSystemFont(ofSize: textSize)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func createTitle(text: String) -> UILabel {
        let view = UILabel()
        view.text = text
        view.font = .boldSystemFont(ofSize: titleSize)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func createStackView(views: [UIView], spacing: CGFloat = 5) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.spacing = spacing
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    func createView() {
        view.backgroundColor = .white
        view.addSubview(nextButton)
        view.addSubview(mainStackView)
                
        nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -24).isActive = true
    }
}

extension CalculatorRuleViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        incomeTextField.textField.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        incomeTextField.textField.layer.borderColor = UIColor.blue.cgColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var text = incomeTextField.textField.text
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                print("Backspace was pressed")
                text?.removeLast()
            } else {
                text?.append(string)
            }
            
            let result = selectedRule.calculatePercentage(incomeSalary: text ?? "")
            assignValues(values: result)
        }
        return true
    }
    
    func assignValues(values: RuleValues) {
        necessitiesLabel.text = values.necessitiesValue
        wantsLabel.text = values.wantsValue
        savingsLabel.text = values.savingsValue
    }
}
