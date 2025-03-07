//
//  AppDelegate.swift Created by Shinren Pan on 2024/2/26.
//
//  Copyright (c) 2024 Shinren Pan All rights reserved.
//

import UIKit
import List

@main class AppDelegate: UIResponder {
    var window: UIWindow?
}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let bounds = UIScreen.main.bounds
        let window = UIWindow(frame: bounds)
        window.backgroundColor = .white
        window.rootViewController = UINavigationController(rootViewController: List.ViewController())
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
}
