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

internal final class ListViewWrapper: NSObject, UITableViewDelegate, UITableViewDataSource, ListViewWrapperActions, UITextFieldDelegate {

    private let view: ListView
    private let cellID = "cell"
    private var elements: [Element] = []
    private var addKeyboardButton: UIBarButtonItem!

    private let actions: ListPresenterActions?
        
    init(view: ListView, presenter: ListPresenterActions) {
        self.view = view
        actions = presenter
    
        super.init()
        
        view.addTextField.delegate = self
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
        elements.append(element)
        view.tableView.insertRows(at: [IndexPath(row: elements.count - 1, section: 0)], with: .fade)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return CustomTableViewCell(text: elements[indexPath.row].title, checked: elements[indexPath.row].done)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell
        cell?.onCellTap(element: elements[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            elements.remove(at: indexPath.row)
            view.tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: indexPath.section)], with: .fade)
            actions?.removeElement(row: indexPath.row)
        }
    }

    private func createKeyboardAccessory() -> UIToolbar {
        let keyboardToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: Metrics.toolBarHeight))
        
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
        addElementAction()
    }
    
    @objc private func textFieldDidChange() {
        addKeyboardButton.isEnabled = !(view.addTextField.text?.isEmpty ?? true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addElementAction()
        return false
    }
    
    private func addElementAction() {
        if let text = view.addTextField.text, !text.isEmpty {
            actions?.addElement(title: view.addTextField.text ?? "")
            view.addTextField.text = nil
        }
    }
}

private extension Metrics {
    static let toolBarHeight: CGFloat = 45
}
