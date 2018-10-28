//
//  AirModel.swift
//  Aireport
//
//  Created by Wenba on 2018/3/26.
//  Copyright © 2018年 ZacJi. All rights reserved.
//


public struct AirResponse: Codable {
    let data: AirModel
}

public struct AirModel: Codable {
    public init(aqi: Int, idx: Int, cityName: String) {
        self.aqi = aqi
        self.idx = idx
        self.city = City(name: cityName)
    }

    public let aqi: Int
    public let idx: Int
    public let city: City
}

public struct City: Codable {
    public let name: String
}
