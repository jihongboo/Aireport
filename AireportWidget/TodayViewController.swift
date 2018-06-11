//
//  TodayViewController.swift
//  AireportWidget
//
//  Created by Wenba on 2018/3/28.
//  Copyright © 2018年 ZacJi. All rights reserved.
//

import UIKit
import NotificationCenter
import AireportKit

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var aqiLable: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(showApp))
        view.addGestureRecognizer(tap)
    }

    @objc func showApp() {
        extensionContext?.open(URL(string: "aireport://")!, completionHandler: nil)
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        AirAPI.getAirReportNow { (airModel) in
            guard let airModel = airModel else {
                return
            }
            self.aqiLable.text = "\(airModel.aqi)"
            self.view.backgroundColor = AirTools.color(aqi: airModel.aqi)
        }
        completionHandler(NCUpdateResult.newData)
    }
    
}
