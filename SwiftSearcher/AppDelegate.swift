//
//  AppDelegate.swift
//  SwiftSearcher
//
//  Created by Matheus Silva on 31/05/21.
//  Copyright © 2021 Matheus Silva. All rights reserved.
//

import UIKit
import CoreSpotlight

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // SpotlightManager

        SpotlightManager.initialize()

        return true
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if userActivity.activityType == CSSearchableItemActionType {
            guard
                let uniqueIdentifier = userActivity.userInfo?[CSSearchableItemActivityIdentifier] as? String,
                let navigationController = window?.rootViewController as? UINavigationController,
                let viewController = navigationController.topViewController as? ViewController
            else { return true }

            viewController.show(uniqueIdentifier)
        }

        return true
    }

}

