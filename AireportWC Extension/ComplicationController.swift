//
//  ComplicationController.swift
//  AireportWC Extension
//
//  Created by 纪洪波 on 2018/10/24.
//  Copyright © 2018 ZacJi. All rights reserved.
//

import ClockKit
import AireportWCKit

class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
        getEntry(complication: complication, handler: handler)
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        let airModel = AirModel(aqi: 0, idx: 0, cityName: "City")
        handler(getTemplate(complication: complication, airModel: airModel))
    }
    
    func getEntry(complication: CLKComplication, handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        AirAPI.getAirReport { (airModel) in
            guard let airModel = airModel, let complication = self.getTemplate(complication: complication, airModel: airModel) else{
                handler(nil)
                return
            }
            handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: complication))
        }
    }
    
    func getTemplate(complication: CLKComplication, airModel: AirModel) -> CLKComplicationTemplate? {
        let aqi = airModel.aqi
        let city = airModel.city.name
        switch complication.family {
        case .circularSmall:
            let template = CLKComplicationTemplateCircularSmallStackText()
            template.line1TextProvider = CLKSimpleTextProvider(text: "AQI")
            template.line2TextProvider = CLKSimpleTextProvider(text: "\(aqi)")
            return template
        case .modularSmall:
            let template = CLKComplicationTemplateModularSmallSimpleText()
            template.textProvider = CLKSimpleTextProvider(text: "AQI \(aqi)")
            return template
        case .modularLarge:
            let template = CLKComplicationTemplateModularLargeStandardBody()
            template.headerTextProvider = CLKSimpleTextProvider(text: "AQI")
            template.body1TextProvider = CLKSimpleTextProvider(text: "\(city)")
            template.body2TextProvider = CLKSimpleTextProvider(text: "\(aqi)")
            return template
        case .utilitarianSmall:
            let template = CLKComplicationTemplateUtilitarianSmallFlat()
            template.textProvider = CLKSimpleTextProvider(text: "\(aqi)")
            template.imageProvider = CLKImageProvider(onePieceImage: UIImage(named: "Complication/Utilitarian")!)
            return template
        case .utilitarianSmallFlat:
            let template = CLKComplicationTemplateUtilitarianSmallFlat()
            template.textProvider = CLKSimpleTextProvider(text: "\(aqi)")
            template.imageProvider = CLKImageProvider(onePieceImage: UIImage(named: "Complication/Utilitarian")!)
            return template
        case .utilitarianLarge:
            let template = CLKComplicationTemplateUtilitarianLargeFlat()
            template.textProvider = CLKSimpleTextProvider(text: "\(aqi)")
            template.imageProvider = CLKImageProvider(onePieceImage: UIImage(named: "Complication/Utilitarian")!)
            return template
        case .extraLarge:
            let template = CLKComplicationTemplateCircularSmallStackText()
            template.line1TextProvider = CLKSimpleTextProvider(text: "AQI")
            template.line2TextProvider = CLKSimpleTextProvider(text: "\(aqi)")
            break
        case .graphicCorner:
            let template = CLKComplicationTemplateGraphicCornerGaugeText()
            template.gaugeProvider = CLKSimpleGaugeProvider(style: .ring, gaugeColors: [.green, .red], gaugeColorLocations: nil, fillFraction: (Float(aqi) / 300.0))
            template.leadingTextProvider = CLKSimpleTextProvider(text: "0")
            template.trailingTextProvider = CLKSimpleTextProvider(text: "300")
            template.outerTextProvider = CLKSimpleTextProvider(text: "\(aqi)")
            return template
        case .graphicBezel:
            let template = CLKComplicationTemplateGraphicBezelCircularText()
            let circularTemplate = CLKComplicationTemplateGraphicCircularImage()
            circularTemplate.imageProvider = CLKFullColorImageProvider(fullColorImage: UIImage(named: "Complication/Graphic Corner")!)
            template.circularTemplate = circularTemplate
            template.textProvider = CLKSimpleTextProvider(text: "\(aqi)")
            return template
        case .graphicCircular:
            let template = CLKComplicationTemplateGraphicCircularOpenGaugeRangeText()
            template.gaugeProvider = CLKSimpleGaugeProvider(style: .ring, gaugeColors: [.green, .red], gaugeColorLocations: nil, fillFraction: (Float(aqi) / 300.0))
            template.leadingTextProvider = CLKSimpleTextProvider(text: "0")
            template.trailingTextProvider = CLKSimpleTextProvider(text: "300")
            template.centerTextProvider = CLKSimpleTextProvider(text: "\(aqi)")
            return template
        case .graphicRectangular:
            let template = CLKComplicationTemplateGraphicRectangularStandardBody()
            template.headerTextProvider = CLKSimpleTextProvider(text: "AQI")
            template.body1TextProvider = CLKSimpleTextProvider(text: "\(city)")
            template.body2TextProvider = CLKSimpleTextProvider(text: "\(aqi)")
            template.headerImageProvider = CLKFullColorImageProvider(fullColorImage: UIImage(named: "Complication/Graphic Corner")!)
            return template
        @unknown default:
            return nil
        }
        return nil
    }
}
