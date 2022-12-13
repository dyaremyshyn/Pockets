//
//  Rule.swift
//  PocketsApp
//
//  Created by User on 07/12/2022.
//

import Foundation

struct Rule: Codable {
    var necessitiesPercentage: Float
    var wantsPercentage: Float
    var savingsPercentage: Float
    
    func calculatePercentage(incomeSalary: String) -> RuleValues {
        var ruleValues = RuleValues(necessitiesValue: "0", wantsValue: "0", savingsValue: "0")
        guard let income = Float(incomeSalary), income > 0 else { return ruleValues.transformValues() }

        ruleValues.necessitiesValue = String(format: "%.0f",(income * (necessitiesPercentage / 100)))
        ruleValues.wantsValue = String(format: "%.0f",(income * (wantsPercentage / 100)))
        ruleValues.savingsValue = String(format: "%.0f",(income * (savingsPercentage / 100)))
        
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

extension Rule {
    func storeValue() {
        guard let encoded = try? JSONEncoder().encode(self) else { return }
        UserDefaults.standard.set(encoded, forKey: "selectedRule")
    }
    
    mutating func retriveValue() {
        guard let data = UserDefaults.standard.object(forKey: "selectedRule") as? Data,
              let object = try? JSONDecoder().decode(Rule.self, from: data) else {
                  return
              }
        self = object
    }
}
