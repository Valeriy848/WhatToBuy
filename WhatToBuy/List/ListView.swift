//
//  ListView.swift
//  WhatToBuy
//
//  Created by Valeriy Pokatilo on 02.01.2022.
//

import UIKit

internal final class ListView: UIView {
    
    let addTextField: UITextField = {
        let addTextField = UITextField()
        addTextField.placeholder = Strings.newProduct
        addTextField.borderStyle = .roundedRect
        addTextField.autocorrectionType = .no
        addTextField.translatesAutoresizingMaskIntoConstraints = false
        return addTextField
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        addSubview(addTextField)
        NSLayoutConstraint.activate([
            addTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Metrics.topOffset),
            addTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.sideOffset),
            addTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.sideOffset)
        ])

        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: addTextField.bottomAnchor, constant: Metrics.topOffset),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

private extension Metrics {
    static let topOffset: CGFloat = 8
}
