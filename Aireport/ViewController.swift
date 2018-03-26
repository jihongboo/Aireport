//
//  ViewController.swift
//  Aireport
//
//  Created by Wenba on 2018/3/26.
//  Copyright © 2018年 ZacJi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var aqiLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        gateDate()
    }

    func gateDate() {
        AirAPI.getAirReport { (airModel) in
            self.aqiLable.text = "\(airModel.aqi)";
            switch airModel.aqi {
            case 0...50:
                self.aqiLable.textColor = #colorLiteral(red: 0.1697491109, green: 0.5999971032, blue: 0.3989009857, alpha: 1)
                break
            case 51...100:
                self.aqiLable.textColor = #colorLiteral(red: 0.9837319255, green: 0.8724730611, blue: 0.1980268359, alpha: 1)
                break
            case 101...150:
                self.aqiLable.textColor = #colorLiteral(red: 0.9706934094, green: 0.5985591412, blue: 0.2020688355, alpha: 1)
                break
            case 151...200:
                self.aqiLable.textColor = #colorLiteral(red: 0.7984669805, green: 0.01951491833, blue: 0.1984502971, alpha: 1)
                break
            case 201...300:
                self.aqiLable.textColor = #colorLiteral(red: 0.3991004229, green: 0, blue: 0.6014233828, alpha: 1)
                break
            default:
                self.aqiLable.textColor = #colorLiteral(red: 0.492726028, green: 0.006434844341, blue: 0.1375600398, alpha: 1)
                break
            }
        }
    }
}

