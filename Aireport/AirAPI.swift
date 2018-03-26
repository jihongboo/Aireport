//
//  AirAPI.swift
//  Aireport
//
//  Created by Wenba on 2018/3/26.
//  Copyright © 2018年 ZacJi. All rights reserved.
//

import UIKit

class AirAPI: NSObject {

    static func getAirReport(completeBlock: @escaping ((_ airModel: AirModel)->())) {
        if let data = UserDefaults.standard.value(forKey: "aqi") as? Data {
            AirAPI.handelData(data: data, completeBlock: completeBlock)
        }

        let request = URLRequest(url: URL(string: "https://api.waqi.info/feed//@482/?token=ff6bd257aab3a6d9a4f0b29625dd9d3668276c7d")!)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            UserDefaults.standard.set(data, forKey: "aqi")
            AirAPI.handelData(data: data!, completeBlock: completeBlock)
            }.resume()
    }

    static func handelData(data:Data, completeBlock: @escaping ((_ airModel: AirModel)->())) {
        let obj = try? JSONDecoder().decode(ResponseModel.self, from: data)
        DispatchQueue.main.async(execute: {
            UIApplication.shared.applicationIconBadgeNumber = (obj?.data.aqi)!
            completeBlock((obj?.data)!)
        })
    }
}
