//
//  AirAPI.swift
//  Aireport
//
//  Created by Wenba on 2018/3/26.
//  Copyright © 2018年 ZacJi. All rights reserved.
//

import UIKit

class AirAPI: NSObject {
    static let token = "ff6bd257aab3a6d9a4f0b29625dd9d3668276c7d"
    static var cityUid: NSInteger! {
        get {
            if let cityUid = UserDefaults.standard.value(forKey: "cityUid") as? NSInteger {
                return cityUid
            }
            return 0
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "cityUid")
        }
    }


    static func getAirReport(completeBlock: @escaping ((_ airModel: AirModel)->())) {
        if let data = UserDefaults.standard.value(forKey: "aqi") as? Data {
            AirAPI.handelData(data: data, completeBlock: completeBlock)
        }
        let city = cityUid! == 0 ? "here" : "@\(cityUid!)"
        let request = URLRequest(url: URL(string: "https://api.waqi.info/feed/\(city)/?token=\(token)")!)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return
            }
            UserDefaults.standard.set(data, forKey: "aqi")
            AirAPI.handelData(data: data, completeBlock: completeBlock)
            }.resume()
    }

    static func getCities(keyword: String, completeBlock: @escaping ((_ places: [Place])->())) {
        let request = URLRequest(url: URL(string: "https://api.waqi.info/search/?token=\(token)&keyword=\(keyword)")!)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, let obj = try? JSONDecoder().decode(PlaceResponse.self, from: data) else {
                return
            }
            DispatchQueue.main.async(execute: {
                completeBlock(obj.data)
            })
            }.resume()
    }

    static func handelData(data:Data, completeBlock: @escaping ((_ airModel: AirModel)->())) {
        if let obj = try? JSONDecoder().decode(AirResponse.self, from: data) {
            DispatchQueue.main.async(execute: {
                UIApplication.shared.applicationIconBadgeNumber = obj.data.aqi
                completeBlock(obj.data)
            })
        }
    }
}
