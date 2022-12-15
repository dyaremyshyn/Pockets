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
        let expensesVC = ExpensesListViewController()
        let expensesTabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: 0)
        expensesVC.tabBarItem = expensesTabBarItem
        
        let tabBarList = [expensesVC]
        viewControllers = tabBarList.map{ UINavigationController(rootViewController: $0) }
    }
}
