//
//  AppDelegate.swift
//  Aireport
//
//  Created by Wenba on 2018/3/26.
//  Copyright © 2018年 ZacJi. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        registerPush()
        UIApplication.shared.setMinimumBackgroundFetchInterval(60 * 60 * 60)
        return true
    }

    func registerPush() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("UserNotifications authorized")
            } else {
                print(error!)
            }
        }
    }

    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        AirAPI.getAirReport { (airModel) in
//            let content = UNMutableNotificationContent()
//            content.badge = NSNumber(value: airModel.aqi)
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
//            let requestIdentifier = "airReport update"
//            let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
//            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        completionHandler(.newData)
    }
}

