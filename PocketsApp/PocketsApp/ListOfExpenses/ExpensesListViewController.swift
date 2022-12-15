//
//  ExpensesListViewController.swift
//  PocketsApp
//
//  Created by User on 13/12/2022.
//

import UIKit

final class ExpensesListViewController: UIViewController {
    var list = [DataModel]()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.register(ExpensesViewCell.self, forCellReuseIdentifier: String(describing: ExpensesViewCell.self))
        view.separatorStyle = .singleLine
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
        setNavigationBar()
    }
    
    func getData() {
        list.append(DataModel(type: .necessity, title: "Continente", description: "Monthly expenses in supermarket", amount: 207.36, date: Date()))
        list.append(DataModel(type: .necessity, title: "Fuel", description: "Refuel car", amount: 84.46, date: Date()))
        list.append(DataModel(type: .want, title: "Monitor Arm", description: "To have more space in my desk setup", amount: 36.97, date: Date()))
        list.append(DataModel(type: .want, title: "Mouse", description: "Logitech Master MX 3 S", amount: 98.20, date: Date()))
        list.append(DataModel(type: .save, title: "Monthly Save", description: "Saving to have a good future", amount: 300, date: Date()))
        list.append(DataModel(type: .save, title: "Monthly Investment", description: "Trading 212 - ETF", amount: 100, date: Date(timeIntervalSinceNow: -35)))
    }
    
    func setNavigationBar() {
        title = "Expenses"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.leftBarButtonItem = nil
    }
    
    func createView() {
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func totalExpenses(section: Int) -> Float {
        var total:Float = 0
        let array = list.filter {$0.type.rawValue == section}
        array.forEach { expense in
            total += expense.amount
        }
        return total
    }
    
    @objc func addTapped() {
        
    }
}

extension ExpensesListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ExpensesListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        DataModel.ExpensesType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.filter { $0.type.rawValue == section }.count
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        header.backgroundColor = .blue
        
        let titleLabel = UILabel(frame: CGRect(x: 20, y: 5, width: view.frame.size.width - 40, height: header.frame.height - 10))
        let expenseTitle = (DataModel.ExpensesType.allCases.first(where: {$0.rawValue == section })?.title ?? "")
        titleLabel.text = expenseTitle + String(format: "%.2f", totalExpenses(section: section)) + "€"
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textColor = .white
        
        header.addSubview(titleLabel)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ExpensesViewCell.self), for: indexPath) as? ExpensesViewCell else {
            return UITableViewCell()
        }
        let array = list.filter { $0.type.rawValue == indexPath.section }
        cell.configure(array[indexPath.row])
        return cell
    }
}
