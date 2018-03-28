//
//  AppDelegate.swift
//  Aireport
//
//  Created by Wenba on 2018/3/26.
//  Copyright © 2018年 ZacJi. All rights reserved.
//

import UIKit
import UserNotifications
import AireportKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        registerPush()
        UIApplication.shared.setMinimumBackgroundFetchInterval(60 * 60)
        return true
    }

    func registerPush() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge]) { (granted, error) in
        }
    }

    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        AirAPI.getAirReport { (airModel) in
        }
        completionHandler(.newData)
    }
}

