//
//  Delegate.swift
//  ghost
//
//  Created by Tomáš Pánik on 28/07/2018.
//  Copyright © 2018 Tomáš Pánik. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UISearchBar.appearance().tintColor = .native
        UINavigationBar.appearance().tintColor = .native
        return true
        
    }
    
}
