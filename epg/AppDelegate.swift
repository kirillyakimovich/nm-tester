//
//  AppDelegate.swift
//  epg
//
//  Created by Yakimovich, Kirill on 9/25/17.
//  Copyright © 2017 Yakimovich, Kirill. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var navigationController = UINavigationController()
    private var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window!.rootViewController = navigationController

        appCoordinator = AppCoordinator(navigationController: navigationController)
        appCoordinator.start()
        window!.makeKeyAndVisible()

        return true
    }
}

