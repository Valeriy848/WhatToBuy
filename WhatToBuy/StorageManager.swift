//
//  StorageManager.swift
//  WhatToBuy
//
//  Created by Valeriy Pokatilo on 06.01.2022.
//

import RealmSwift

internal let realm = try! Realm()

internal final class StorageManager {
    
    static func saveObject(_ element: Element) {
        try! realm.write({
            realm.add(element)
            print("### write \(element.title)")
        })
    }
    
    static func deleteObject(_ element: Element) {
        try! realm.write({
            print("### delete \(element.title)")
            realm.delete(element)
        })
    }
}
