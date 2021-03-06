//
//  AppDelegate.swift
//  WhatToBuy
//
//  Created by Valeriy Pokatilo on 02.01.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ListViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

