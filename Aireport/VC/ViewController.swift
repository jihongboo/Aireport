//
//  ViewController.swift
//  Aireport
//
//  Created by Wenba on 2018/3/26.
//  Copyright © 2018年 ZacJi. All rights reserved.
//

import UIKit
import AireportKit

class ViewController: UIViewController {
    @IBOutlet weak var aqiLable: UILabel!
    @IBOutlet weak var cityLable: UILabel!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(getDate), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDate()
    }

    @objc func getDate() {
        AirAPI.getAirReportNow { (airModel) in
            guard let airModel = airModel else {
                self.cityLable.text = "Ohps"
                self.aqiLable.text = "000"
                return
            }
            self.cityLable.text = airModel.city.name
            self.aqiLable.text = "\(airModel.aqi)"
            self.view.backgroundColor = AirTools.color(aqi: airModel.aqi)
            UIApplication.shared.applicationIconBadgeNumber = airModel.aqi
        }
    }
}

