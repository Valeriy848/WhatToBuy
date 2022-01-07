//
//  ListPresenter.swift
//  WhatToBuy
//
//  Created by Valeriy Pokatilo on 03.01.2022.
//

import RealmSwift

internal protocol ListPresenterActions {
    func addElement(title: String)
    func removeElement(row: Int)
}

internal final class ListPresenter: ListPresenterActions {
    
    private var view: ListViewWrapperActions? = nil
    private var allElements: Results<Element>!

    func attachView(view: ListViewWrapperActions) {
        self.view = view
        
        allElements = realm.objects(Element.self).sorted(byKeyPath: "date", ascending: false)
        
        getData()
    }

    func detachView() {
        view = nil
    }
    
    private func getData() {
        allElements = realm.objects(Element.self)
        view?.onDataReceived(elements: Array(allElements))
    }
    
    func addElement(title: String) {
        let element = Element(title: title, date: Date(), done: false)
        StorageManager.saveObject(element)
        view?.insertElement(element: element)
    }
    
    func removeElement(row: Int) {
        let element = allElements[row]
        StorageManager.deleteObject(element)
    }
}
