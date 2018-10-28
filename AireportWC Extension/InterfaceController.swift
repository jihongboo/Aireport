//
//  InterfaceController.swift
//  AireportWC Extension
//
//  Created by 纪洪波 on 2018/10/24.
//  Copyright © 2018 ZacJi. All rights reserved.
//

import WatchKit
import Foundation
import AireportWCKit

class InterfaceController: WKInterfaceController {
    @IBOutlet weak var background: WKInterfaceGroup!
    @IBOutlet weak var cityLable: WKInterfaceLabel!
    @IBOutlet weak var aqiLable: WKInterfaceLabel!
    
    private var airModel: AirModel? {
        didSet {
            guard let airModel = airModel else {
                self.cityLable.setText("Ohps")
                self.aqiLable.setText("000")
                return
            }
            self.cityLable.setText(airModel.city.name)
            self.aqiLable.setText("\(airModel.aqi)")
            self.background.setBackgroundColor(AirTools.color(aqi: airModel.aqi))
        }
    }
    @IBAction func refreshData(_ sender: Any) {
        AirAPI.getAirReportNow { (airModel) in
            self.airModel = airModel
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        refreshData(self)

        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
