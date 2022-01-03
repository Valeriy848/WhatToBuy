//
//  ListPresenter.swift
//  WhatToBuy
//
//  Created by Valeriy Pokatilo on 03.01.2022.
//

import Foundation

internal protocol ListPresenterActions {
    func addElement(title: String)
}

internal final class ListPresenter: ListPresenterActions {
    
    private var view: ListViewWrapperActions? = nil

    func attachView(view: ListViewWrapperActions) {
        self.view = view
        getData()
    }

    func detachView() {
        view = nil
    }
    
    private func getData() {
        view?.onDataReceived(elements: [Element(title: "Мясо", date: Date()),
                                        Element(title: "Картошка", date: Date()),
                                        Element(title: "Апельсины", date: Date()),
                                        Element(title: "Масло", date: Date()),
                                        Element(title: "Колбаса", date: Date())],
                             chekedElements: [Element(title: "Яйца", date: Date()),
                                              Element(title: "Сыр", date: Date())])
    }
    
    func addElement(title: String) {
        view?.insertElement(element: Element(title: title, date: Date()))
    }
}
