//
//  AppDelegate.swift
//  Shoppee
//
//  Created by Mạnh Hoàng Xuân on 05/08/2022.
//

import UIKit
import RevenueCat

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Setup RevenueCat
        Purchases.configure(withAPIKey: "appl_wdQAymKpHVIyksGJrJgAOySYKyw")
        Purchases.logLevel = .debug
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

