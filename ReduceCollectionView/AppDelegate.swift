//
//  AppDelegate.swift
//  ReduceCollectionView
//
//  Created by 김동준 on 2021/04/12.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window  : UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = StartVC()
        return true
    }
}

