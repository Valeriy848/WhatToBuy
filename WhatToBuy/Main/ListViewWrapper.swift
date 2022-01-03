//
//  ListViewWrapper.swift
//  WhatToBuy
//
//  Created by Valeriy Pokatilo on 03.01.2022.
//

import UIKit

internal protocol ListViewWrapperActions {
    func setupTableView()
    func onDataReceived(elements: [Element])
    func insertElement(element: Element)
}

internal final class ListViewWrapper: NSObject, UITableViewDelegate, UITableViewDataSource, ListViewWrapperActions {
    
    private let view: ListView
    private let cellID = "cell"
    private var elements: [Element] = []
    private var addKeyboardButton: UIBarButtonItem!
    
    private let actions: ListPresenterActions?
        
    init(view: ListView, presenter: ListPresenterActions) {
        self.view = view
        actions = presenter
        super.init()
        setupTableView()
    }
    
    func setupTableView() {
        view.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellID)
        view.tableView.delegate = self
        view.tableView.dataSource = self
        
        setupKeyboard()
        
        view.addTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    func setupKeyboard() {
        view.addTextField.inputAccessoryView = createKeyboardAccessory()
    }
    
    func onDataReceived(elements: [Element]) {
        self.elements = elements
        view.tableView.reloadData()
    }
    
    func insertElement(element: Element) {
        elements.insert(element, at: 0)
        view.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CustomTableViewCell(text: elements[indexPath.row].title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell
        cell?.onCellTap()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func createKeyboardAccessory() -> UIToolbar {
        let keyboardToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 45))
        
        let hideKeyboardButton = UIBarButtonItem(title: Strings.hideKeyboard, style: .done, target: self, action: #selector(hideKeyboard))
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        addKeyboardButton = UIBarButtonItem(title: Strings.addElement, style: .done, target: self, action: #selector(addElement))
        addKeyboardButton.isEnabled = false

        keyboardToolBar.items = [hideKeyboardButton, flexBarButton, addKeyboardButton]
        
        return keyboardToolBar
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func addElement() {
        actions?.addElement(title: view.addTextField.text ?? "")
        view.addTextField.text = nil
    }
    
    @objc private func textFieldDidChange() {
        addKeyboardButton.isEnabled = !(view.addTextField.text?.isEmpty ?? true)
    }
}
