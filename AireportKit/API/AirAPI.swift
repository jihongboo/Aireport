//
//  AirAPI.swift
//  Aireport
//
//  Created by Wenba on 2018/3/26.
//  Copyright © 2018年 ZacJi. All rights reserved.
//

import UIKit

public class AirAPI: NSObject {
    static let token = "ff6bd257aab3a6d9a4f0b29625dd9d3668276c7d"
    public static var cityUid: NSInteger! {
        get {
            if let cityUid = userDefault.value(forKey: "cityUid") as? NSInteger {
                return cityUid
            }
            return 0
        }
        set {
            userDefault.set(newValue, forKey: "cityUid")
        }
    }
    static let userDefault = UserDefaults(suiteName: "group.aireport.widget")!


    public static func getAirReportNow(completeBlock: @escaping ((_ airModel: AirModel?)->())) {
        if let data = userDefault.value(forKey: "aqi") as? Data {
            AirAPI.handelData(data: data, completeBlock: completeBlock)
        }
        AirAPI.getAirReport(completeBlock: completeBlock)
    }

    public static func getAirReport(completeBlock: @escaping ((_ airModel: AirModel?)->())) {
        let city = cityUid! == 0 ? "here" : "@\(cityUid!)"
        let request = URLRequest(url: URL(string: "https://api.waqi.info/feed/\(city)/?token=\(token)")!)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return
            }
            userDefault.set(data, forKey: "aqi")
            AirAPI.handelData(data: data, completeBlock: completeBlock)
            }.resume()
    }

    public static func getCities(keyword: String, completeBlock: @escaping ((_ places: [Place])->())) {
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

    static func handelData(data:Data, completeBlock: @escaping ((_ airModel: AirModel?)->())) {
        if let obj = try? JSONDecoder().decode(AirResponse.self, from: data) {
            DispatchQueue.main.async(execute: {
                completeBlock(obj.data)
            })
        }else {
            completeBlock(nil)
        }
    }
}
