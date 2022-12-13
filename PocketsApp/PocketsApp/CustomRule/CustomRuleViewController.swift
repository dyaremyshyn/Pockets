//
//  CustomRuleViewController.swift
//  PocketsApp
//
//  Created by User on 13/12/2022.
//

import UIKit

final class CustomRuleViewController: UIViewController {
    //MARK: Vars
    var rule: Rule?
    var necessitiesValue: Float = 0.0
    var wantsValue: Float = 0.0
    var savingsValue: Float = 0.0
    var validValue = false
    
    lazy var necessitiesSlider: RuleSliderView = {
        let view = RuleSliderView(title: "NECESSITIES", completion: {[weak self] slider in
            self?.necessitiesValue = slider.value
            self?.validateValues()
        })
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var wantsSlider: RuleSliderView = {
        let view = RuleSliderView(title: "WANTS", completion: {[weak self] slider in
            self?.wantsValue = slider.value
            self?.validateValues()
        })
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var savingsSlider: RuleSliderView = {
        let view = RuleSliderView(title: "SAVINGS AND DEBT REPAYMENT", completion: {[weak self] slider in
            self?.savingsValue = slider.value
            self?.validateValues()
        })
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var totalPercentageLabel: UILabel = {
        let view = UILabel()
        view.text = "Total: 0%"
        view.textColor = .blue
        view.font = .boldSystemFont(ofSize: 30)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [necessitiesSlider, wantsSlider, savingsSlider])
        stackView.axis = .vertical
        stackView.spacing = 5
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
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
    }
    
    //MARK: Create View
    func createView() {
        view.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.text = "Let's create your Rule!"
        titleLabel.font = .boldSystemFont(ofSize: 30)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        view.addSubview(mainStackView)
        view.addSubview(totalPercentageLabel)
        view.addSubview(nextButton)
        
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        mainStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 35).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -24).isActive = true
        
        totalPercentageLabel.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 20).isActive = true
        totalPercentageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
    }
    
    //MARK: Selectors
    @objc func nextView() {
        if validValue {
            let vc = CalculatorRuleViewController(selectedRule: Rule(necessitiesPercentage: necessitiesValue, wantsPercentage: wantsValue, savingsPercentage: savingsValue))
            self.show(vc, sender: self)
        }
    }
    
    func validateValues() {
        let total = necessitiesValue + wantsValue + savingsValue
        totalPercentageLabel.textColor = total > 100 ? .red : .blue
        totalPercentageLabel.text = "Total: " + String(format: "%.0f", total) + "%"
        
        validValue = total == 100
        nextButton.isEnabled = validValue
        let color: UIColor = validValue ? .blue : .lightGray
        nextButton.setTitleColor(color, for: .normal)
    }
}
