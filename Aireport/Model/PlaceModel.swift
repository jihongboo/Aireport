//
//  PlaceModel.swift
//  Aireport
//
//  Created by Wenba on 2018/3/27.
//  Copyright © 2018年 ZacJi. All rights reserved.
//

import UIKit

struct PlaceResponse: Codable {
    var data: [Place]
}

struct Place: Codable {
    var uid: NSInteger
    var aqi: String
    var station: Station
}

struct Station: Codable {
    var name: String
}
