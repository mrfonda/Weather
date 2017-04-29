//
//  DayWeather.swift
//  Weather
//
//  Created by Vladislav Dorfman on 29/04/2017.
//  Copyright © 2017 Vladislav Dorfman. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class DayWeather : Object, Mappable {
    dynamic var validTime = Date()
    dynamic var weatherPrimary  = "Mostly Sunny"
    dynamic var icon = "pcloudy.png"
    dynamic var maxTempC = 23
    dynamic var maxTempF = 73
    dynamic var minTempC = 9
    dynamic var minTempF = 48
    dynamic var avgTempC = 16
    dynamic var avgTempF = 61
    
//    override static func primaryKey() -> String? {
//        return "validTime"
//    }
    
    //Impl. of Mappable protocol
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
 
        validTime <- map["validTime"]
        weatherPrimary <- map["weatherPrimary"]
        icon <- map["icon"]
        maxTempC <- map["maxTempC"]
        maxTempF <- map["maxTempF"]
        minTempC <- map["minTempC"]
        minTempF <- map["minTempF"]
        avgTempC <- map["avgTempC"]
        avgTempF <- map["avgTempF"]
    }
}

/*
 "success": true,
 "error": null,
 "response": [
 {
 "loc": {
 "long": -122.038,
 "lat": 37.332
 },
 "interval": "day",
 "periods": [
 {
 "timestamp": 1493388000,
 "validTime": "2017-04-28T07:00:00-07:00",
 "dateTimeISO": "2017-04-28T07:00:00-07:00",
 "maxTempC": 23,
 "maxTempF": 73,
 "minTempC": 9,
 "minTempF": 48,
 "avgTempC": 16,
 "avgTempF": 61,
 "tempC": null,
 "tempF": null,
 "pop": 0,
 "precipMM": 0,
 "precipIN": 0,
 "iceaccum": null,
 "maxHumidity": 73,
 "minHumidity": 25,
 "humidity": 55,
 "uvi": 10,
 "pressureMB": 1016,
 "pressureIN": 30,
 "sky": 9,
 "snowCM": 0,
 "snowIN": 0,
 "feelslikeC": 9,
 "feelslikeF": 48,
 "minFeelslikeC": 9,
 "minFeelslikeF": 48,
 "maxFeelslikeC": 23,
 "maxFeelslikeF": 73,
 "avgFeelslikeC": 19,
 "avgFeelslikeF": 66,
 "dewpointC": -10,
 "dewpointF": 14,
 "maxDewpointC": 16,
 "maxDewpointF": 61,
 "minDewpointC": -10,
 "minDewpointF": 14,
 "avgDewpointC": 9,
 "avgDewpointF": 48,
 "windDirDEG": 310,
 "windDir": "NW",
 "windDirMaxDEG": 320,
 "windDirMax": "NW",
 "windDirMinDEG": 320,
 "windDirMin": "NW",
 "windGustKTS": 21,
 "windGustKPH": 39,
 "windGustMPH": 24,
 "windSpeedKTS": 12,
 "windSpeedKPH": 22,
 "windSpeedMPH": 14,
 "windSpeedMaxKTS": 16,
 "windSpeedMaxKPH": 30,
 "windSpeedMaxMPH": 18,
 "windSpeedMinKTS": 7,
 "windSpeedMinKPH": 13,
 "windSpeedMinMPH": 8,
 "windDir80mDEG": 319,
 "windDir80m": "NW",
 "windDirMax80mDEG": 320,
 "windDirMax80m": "NW",
 "windDirMin80mDEG": 320,
 "windDirMin80m": "NW",
 "windGust80mKTS": 22,
 "windGust80mKPH": 41,
 "windGust80mMPH": 25,
 "windSpeed80mKTS": 16,
 "windSpeed80mKPH": 30,
 "windSpeed80mMPH": 19,
 "windSpeedMax80mKTS": 22,
 "windSpeedMax80mKPH": 41,
 "windSpeedMax80mMPH": 25,
 "windSpeedMin80mKTS": 9,
 "windSpeedMin80mKPH": 17,
 "windSpeedMin80mMPH": 11,
 "weather": "Mostly Sunny",
 "weatherCoded": [],
 "weatherPrimary": "Mostly Sunny",
 "weatherPrimaryCoded": "::FW",
 "cloudsCoded": "FW",
 "icon": "pcloudy.png",
 "isDay": true,
 "sunrise": 1493385316,
 "sunriseISO": "2017-04-28T06:15:16-07:00",
 "sunset": 1493434543,
 "sunsetISO": "2017-04-28T19:55:43-07:00"
 },
 */
