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
    dynamic var maxTempC = 0
    dynamic var maxTempF = 0
    dynamic var minTempC = 0
    dynamic var minTempF = 0
    dynamic var avgTempC = 0
    dynamic var avgTempF = 0
  
    
    //Impl. of Mappable protocol
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
 
        validTime <- (map["validTime"], DateTransform())
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


