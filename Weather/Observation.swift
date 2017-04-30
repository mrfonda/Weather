//
//  Observation.swift
//  Weather
//
//  Created by Vladislav Dorfman on 30/04/2017.
//  Copyright © 2017 Vladislav Dorfman. All rights reserved.
//


import Foundation
import ObjectMapper
import RealmSwift

class Observation : Object, Mappable {
    dynamic var dateTimeISO = Date()
    dynamic var weatherPrimary  = "Mostly Sunny"
    dynamic var icon = "pcloudy.png"
    dynamic var tempC = 0
    dynamic var tempF = 0
 
    
    //    override static func primaryKey() -> String? {
    //        return "validTime"
    //    }
    
    //Impl. of Mappable protocol
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        dateTimeISO <- (map["dateTimeISO"], DateTransform())
        weatherPrimary <- map["weatherPrimary"]
        icon <- map["icon"]
        tempC <- map["tempC"]
        tempF <- map["tempF"]

    }
}


