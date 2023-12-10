//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Nikita Grabar on 8.12.23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        root()
        return true
    }
    
    func root() {
        let tabbar = DashboardTabBarVC()
        tabbar.modalPresentationStyle = .fullScreen
        self.window?.rootViewController = tabbar
    }

}

