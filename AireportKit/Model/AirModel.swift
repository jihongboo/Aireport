//
//  AirModel.swift
//  Aireport
//
//  Created by Wenba on 2018/3/26.
//  Copyright © 2018年 ZacJi. All rights reserved.
//

import UIKit

public struct AirResponse: Codable {
    var data: AirModel
}

public struct AirModel: Codable {
    public var aqi: NSInteger
    public var idx: NSInteger
    public var city: City
}

public struct City: Codable {
    public var name: String
}
