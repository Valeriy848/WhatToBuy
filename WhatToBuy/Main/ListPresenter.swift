//
//  ListPresenter.swift
//  WhatToBuy
//
//  Created by Valeriy Pokatilo on 03.01.2022.
//

import Foundation

internal protocol ListPresenterActions {
    func getData()
}

internal final class ListPresenter: ListPresenterActions {
    
    private var view: ListViewWrapper? = nil

    func attachView(view: ListViewWrapper) {
        self.view = view
        view.setupTableView()
    }

    func detachView() {
        view = nil
    }
    
    func getData() {
        view?.receiveData(foods: ["Мясо", "Картошка", "Апельсины", "Масло", "Колбаса", "Яйца", "Сыр"])
    }
}
