//
//  UIView+Ext.swift
//  WhatToBuy
//
//  Created by Valeriy Pokatilo on 03.01.2022.
//

import UIKit

extension Optional where Wrapped == UIView {
    func originalType<T: UIView>() -> T {
        // swiftlint:disable force_cast
        return self as! T
        // swiftlint:enable force_cast
    }
}
