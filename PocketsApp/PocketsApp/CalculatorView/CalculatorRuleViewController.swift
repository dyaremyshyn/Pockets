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
        let view = UILabel()
        view.text = "Monthly after-tax income"
        view.font = .boldSystemFont(ofSize: titleSize)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var incomeTextField: UITextField = {
        let view = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        view.font = .boldSystemFont(ofSize: titleSize)
        view.layer.borderWidth = 0.5
        view.delegate = self
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.placeholder = "0€"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var necessitiesLabel: UILabel = {
        let view = UILabel()
        view.textColor = .blue
        view.text = "0€"
        view.font = .boldSystemFont(ofSize: textSize)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var wantsLabel: UILabel = {
        let view = UILabel()
        view.textColor = .blue
        view.text = "0€"
        view.font = .boldSystemFont(ofSize: textSize)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var savingsLabel: UILabel = {
        let view = UILabel()
        view.textColor = .blue
        view.text = "0€"
        view.font = .boldSystemFont(ofSize: textSize)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var necessitiesTitle: UILabel = {
        let view = UILabel()
        view.text = "NECESSITIES"
        view.font = .boldSystemFont(ofSize: titleSize)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var wantsTitle: UILabel = {
        let view = UILabel()
        view.text = "WANTS"
        view.font = .boldSystemFont(ofSize: titleSize)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var savingsTitle: UILabel = {
        let view = UILabel()
        view.text = "SAVINGS AND DEBT REPAYMENT"
        view.font = .boldSystemFont(ofSize: titleSize)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var necessitiesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [necessitiesTitle, necessitiesLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var wantsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [wantsTitle, wantsLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var savingsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [savingsTitle, savingsLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var incomeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [incomeTitle, incomeTextField])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            incomeStackView,
            necessitiesStackView,
            wantsStackView,
            savingsStackView
        ])
        stackView.spacing = 25
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var nextButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setTitle("Next", for: .normal)
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
    func createView() {
        view.backgroundColor = .white
        view.addSubview(nextButton)
        view.addSubview(mainStackView)
                
        nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -24).isActive = true
    }
}

extension CalculatorRuleViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var text = incomeTextField.text
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                print("Backspace was pressed")
                text?.removeLast()
            } else {
                text?.append(string)
            }
            
            //calculateBudget(valueString: text ?? "")
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
