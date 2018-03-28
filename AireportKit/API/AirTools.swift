//
//  AirTools.swift
//  AireportKit
//
//  Created by Wenba on 2018/3/28.
//  Copyright © 2018年 ZacJi. All rights reserved.
//

import UIKit

public class AirTools: NSObject {
    public static func color(aqi: NSInteger) ->(UIColor) {
        var color = #colorLiteral(red: 0.492726028, green: 0.006434844341, blue: 0.1375600398, alpha: 1)
        switch aqi {
        case 0...50:
            color = #colorLiteral(red: 0.1860606074, green: 0.6550217271, blue: 0.3816407025, alpha: 1)
            break
        case 51...100:
            color = #colorLiteral(red: 0.9837319255, green: 0.8724730611, blue: 0.1980268359, alpha: 1)
            break
        case 101...150:
            color = #colorLiteral(red: 0.9706934094, green: 0.5985591412, blue: 0.2020688355, alpha: 1)
            break
        case 151...200:
            color = #colorLiteral(red: 0.7984669805, green: 0.01951491833, blue: 0.1984502971, alpha: 1)
            break
        case 201...300:
            color = #colorLiteral(red: 0.3991004229, green: 0, blue: 0.6014233828, alpha: 1)
            break
        default:
            break
        }
        return color
    }
}
