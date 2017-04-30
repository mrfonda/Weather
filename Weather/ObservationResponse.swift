//
//  ObservationResponse.swift
//  Weather
//
//  Created by Vladislav Dorfman on 30/04/2017.
//  Copyright © 2017 Vladislav Dorfman. All rights reserved.
//

import Foundation

import ObjectMapper
import RealmSwift

class ObservationResponse :  Mappable {
    var success = false
    var response = [ObservationResponseItem]()
    
    //Impl. of Mappable protocol
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        response <- map["response"]
    }
}
class ObservationResponseItem :  Mappable {
    var ob = [Observation]()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        ob <- map["ob"]
    }
}




/*
 {
 "success": true,
 "error": null,
 "response": {
 "id": "UWWW",
 "loc": {
 "long": 50.166666666667,
 "lat": 53.5
 },
 "place": {
 "name": "kurumoch",
 "state": "",
 "country": "ru"
 },
 "profile": {
 "tz": "Europe/Samara",
 "elevM": 146,
 "elevFT": 479
 },
 "obTimestamp": 1493512200,
 "obDateTime": "2017-04-30T04:30:00+04:00",
 "ob": {
 "timestamp": 1493512200,
 "dateTimeISO": "2017-04-30T04:30:00+04:00",
 "tempC": 8,
 "tempF": 46,
 "dewpointC": 2,
 "dewpointF": 36,
 "humidity": 66,
 "pressureMB": 1029,
 "pressureIN": 30.39,
 "spressureMB": 1011,
 "spressureIN": 29.85,
 "altimeterMB": 1029,
 "altimeterIN": 30.39,
 "windKTS": 8,
 "windKPH": 14,
 "windMPH": 9,
 "windSpeedKTS": 8,
 "windSpeedKPH": 14,
 "windSpeedMPH": 9,
 "windDirDEG": 220,
 "windDir": "SW",
 "windGustKTS": null,
 "windGustKPH": null,
 "windGustMPH": null,
 "flightRule": "LIFR",
 "visibilityKM": 11.265408,
 "visibilityMI": 7,
 "weather": "Clear",
 "weatherShort": "Clear",
 "weatherCoded": "::CL",
 "weatherPrimary": "Clear",
 "weatherPrimaryCoded": "::CL",
 "cloudsCoded": "CL",
 "icon": "clearn.png",
 */
