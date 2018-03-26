//
//  AirModel.swift
//  Aireport
//
//  Created by Wenba on 2018/3/26.
//  Copyright © 2018年 ZacJi. All rights reserved.
//

import UIKit

enum ResponseStatus: String, Codable {
    case ok
    case error
}

struct ResponseModel: Codable {
    var status: ResponseStatus
    var data: AirModel
}

struct AirModel: Codable {
    var aqi: NSInteger
    var idx: NSInteger
    var city: City
}

struct City: Codable {
    var name: String
}
