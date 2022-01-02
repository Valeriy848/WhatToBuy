//
//  ListViewWrapper.swift
//  WhatToBuy
//
//  Created by Valeriy Pokatilo on 03.01.2022.
//

import UIKit

internal protocol ListViewWrapperActions {
    func setupTableView()
    func receiveData(foods: [String])
}

internal final class ListViewWrapper: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    private let view: ListView
    private let cellID = "cell"
    private var foods: [String] = []
        
    init(view: ListView) {
        self.view = view
    }
    
    func setupTableView() {
        view.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellID)
        view.tableView.delegate = self
        view.tableView.dataSource = self
    }
    
    func receiveData(foods: [String]) {
        self.foods = foods
        view.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CustomTableViewCell(text: foods[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell
        cell?.onCellTap()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
