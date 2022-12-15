//
//  PocketsTabBarController.swift
//  PocketsApp
//
//  Created by User on 15/12/2022.
//

import UIKit

final class PocketsTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
        addViewControllers()
    }
    
    func setTabBar() {
        tabBar.barTintColor = .white
        tabBar.tintColor = .blue
        tabBar.unselectedItemTintColor = .black
    }
    
    func addViewControllers() {
        //let firstViewTabBarItem = UITabBarItem(title: "First", image: UIImage(named: "calculator"), selectedImage: UIImage(named: "calculator"))

        let expensesVC = ExpensesListViewController()
        let expensesTabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 0)
        expensesVC.tabBarItem = expensesTabBarItem
        expensesVC.tabBarItem.title = "Expense List"
        
        var rule = Rule(necessitiesPercentage: 0, wantsPercentage: 0, savingsPercentage: 0)
        let manageVC = CalculatorRuleViewController(selectedRule: rule.retriveValue() ?? rule)
        let manageTabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        manageVC.tabBarItem = manageTabBarItem
        manageVC.tabBarItem.title = "Manage Income"
        
        let customRuleVC = CustomRuleViewController()
        customRuleVC.rule = rule
        let customTabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 2)
        customRuleVC.tabBarItem = customTabBarItem
        customRuleVC.tabBarItem.title = "Change Rule"
        
        let tabBarList = rule.isDefaultRule() ? [expensesVC, manageVC] : [expensesVC, customRuleVC]
        viewControllers = tabBarList.map{ UINavigationController(rootViewController: $0) }
    }
}
