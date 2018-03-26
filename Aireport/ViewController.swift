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
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

