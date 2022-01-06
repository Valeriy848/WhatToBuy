//
//  Element.swift
//  WhatToBuy
//
//  Created by Valeriy Pokatilo on 03.01.2022.
//

import RealmSwift // ***

internal final class Element: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var date: Date = Date()
    @objc dynamic var done: Bool = false

    convenience init(title: String, date: Date, done: Bool) {
        self.init()
        self.title = title
        self.date = date
        self.done = done
    }
}
