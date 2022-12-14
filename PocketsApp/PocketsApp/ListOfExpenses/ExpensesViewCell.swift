//
//  ExpensesViewCell.swift
//  PocketsApp
//
//  Created by User on 14/12/2022.
//

import UIKit

class ExpensesViewCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 20)
        view.textColor = .blue
        view.text = "------"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16)
        view.text = "------"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var dateLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 10)
        view.text = "------"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var amountLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 20)
        view.text = "------"
        view.textColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var horizontalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, amountLabel])
        view.axis = .horizontal
        view.spacing = 5
        view.alignment = .fill
        view.distribution = .equalSpacing
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var verticalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [horizontalStackView, descriptionLabel, dateLabel])
        view.axis = .vertical
        view.spacing = 5
        view.alignment = .fill
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(verticalStackView)
        
        verticalStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        verticalStackView.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
    }
    
    func configure(_ viewModel: DataModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        amountLabel.text = String(format: "%0.2f", viewModel.amount) + "€"
        dateLabel.text = viewModel.date.formatDate()
    }
}
