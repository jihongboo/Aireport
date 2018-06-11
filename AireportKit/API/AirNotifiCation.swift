//
//  AirNotifiCation.swift
//  AireportKit
//
//  Created by Wenba on 2018/4/26.
//  Copyright © 2018年 ZacJi. All rights reserved.
//

import UIKit
import UserNotifications

public class AirNotification: NSObject {
    public static func regist() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.badge, .alert, .sound]) { (granted, error) in
        }
        center.getNotificationSettings { (settings) in
        }
    }

    public static func sendNotification(air: AirModel) {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.badge = NSNumber(value: air.aqi)
        if(air.aqi > 100) {
            content.title = AirTools.aqiState(aqi: air.aqi)
            content.body = "当前空气质量指数为\(air.aqi)"
        }
        let request = UNNotificationRequest(identifier: "AQI", content: content, trigger: nil)
        center.add(request, withCompletionHandler: { (error) in
        })

    }
}
