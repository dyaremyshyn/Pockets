//
//  Rule.swift
//  PocketsApp
//
//  Created by User on 07/12/2022.
//

import Foundation

struct Rule {
    var necessitiesPercentage: Float
    var wantsPercentage: Float
    var savingsPercentage: Float
    
    func calculatePercentage(incomeSalary: String) -> RuleValues {
        var ruleValues = RuleValues(necessitiesValue: "0", wantsValue: "0", savingsValue: "0")
        guard let income = Float(incomeSalary), income > 0 else { return ruleValues.transformValues() }

        ruleValues.necessitiesValue = String(format: "%.2f",(income * (necessitiesPercentage / 100)))
        ruleValues.wantsValue = String(format: "%.2f",(income * (wantsPercentage / 100)))
        ruleValues.savingsValue = String(format: "%.2f",(income * (savingsPercentage / 100)))
        
        return ruleValues.transformValues()
    }
}

struct RuleValues {
    var necessitiesValue: String
    var wantsValue: String
    var savingsValue: String
    
    mutating func transformValues() -> RuleValues {
        necessitiesValue += "€"
        wantsValue += "€"
        savingsValue += "€"
        return self
    }
}
