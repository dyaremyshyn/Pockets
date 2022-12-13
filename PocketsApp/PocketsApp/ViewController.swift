//
//  ViewController.swift
//  PocketsApp
//
//  Created by User on 05/12/2022.
//

import UIKit

final class ViewController: UIViewController {

    let descriptionSubtitle: String = "50% of your income: needs\n30% of your income: wants\n20% of your income: savings and debt"
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var firstRuleRadioButton: CheckBox!
    @IBOutlet weak var secondRuleRadioButton: CheckBox!
    @IBOutlet weak var descriptionFirstRuleLabel: UILabel!
    var isCustomRuleSelected: Bool = false
    var isRuleSelected: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        descriptionFirstRuleLabel.numberOfLines = 0
        descriptionFirstRuleLabel.text = descriptionSubtitle
        firstRuleRadioButton.tag = 1
        secondRuleRadioButton.tag = 2
        
        firstRuleRadioButton.addTarget(self, action: #selector(ruleSelected(sender:)), for: .touchUpInside)
        secondRuleRadioButton.addTarget(self, action: #selector(ruleSelected(sender:)), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
    }

    @objc func ruleSelected(sender: CheckBox) {
        isRuleSelected = true
        isCustomRuleSelected = sender.tag == 2 ? sender.isChecked : !sender.isChecked
        firstRuleRadioButton.isChecked = !isCustomRuleSelected
        secondRuleRadioButton.isChecked = isCustomRuleSelected
        print(isCustomRuleSelected ? "Custom Rule Selected" : "50 30 20 Rule Selected")
    }

    @objc func nextStep() {
        if isRuleSelected && !isCustomRuleSelected {
            let vc = CalculatorRuleViewController(selectedRule: Rule(necessitiesPercentage: 50.0, wantsPercentage: 30.0, savingsPercentage: 20.0))
            self.show(vc, sender: self)
        } else {
            let vc = CustomRuleViewController()
            self.show(vc, sender: self)
        }
    }
}
