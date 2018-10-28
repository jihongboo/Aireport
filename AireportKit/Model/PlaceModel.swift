//
//  PlaceModel.swift
//  Aireport
//
//  Created by Wenba on 2018/3/27.
//  Copyright © 2018年 ZacJi. All rights reserved.
//

public struct PlaceResponse: Codable {
    var data: [Place]
}

public struct Place: Codable {
    public var uid: NSInteger
    public var aqi: String
    public var station: Station
}

public struct Station: Codable {
    public var name: String
}
