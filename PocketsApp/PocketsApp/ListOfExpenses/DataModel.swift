//
//  DataModel.swift
//  PocketsApp
//
//  Created by User on 14/12/2022.
//

import Foundation

struct DataModel {
    enum ExpensesType: Int, CaseIterable {
        case necessity = 0
        case want = 1
        case save = 2
        
        var title: String {
            switch self {
            case .necessity:
                return "NECESSITIES"
            case .want:
                return "WANTS"
            case .save:
                return "SAVINGS"
            }
        }
    }
    var type: ExpensesType
    var title: String
    var description: String
    var amount: Float
    var date: Date
}

extension Date {
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: self)
    }
}
