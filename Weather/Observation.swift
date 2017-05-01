//
//  Observation.swift
//  Weather
//
//  Created by Vladislav Dorfman on 30/04/2017.
//  Copyright © 2017 Vladislav Dorfman. All rights reserved.
//


import Foundation
import ObjectMapper

class Observation : Mappable {
  var dateTimeISO = Date()
  var weatherPrimary  = "Mostly Sunny"
  var icon = "pcloudy.png"
  var tempC = 0
  var tempF = 0
  
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


