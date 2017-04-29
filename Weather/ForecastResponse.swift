//
//  ForecastResponse.swift
//  Weather
//
//  Created by Vladislav Dorfman on 29/04/2017.
//  Copyright © 2017 Vladislav Dorfman. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class ForecastResponce :  Mappable {
    var success = false
    var response = [Response]()
    
    //Impl. of Mappable protocol
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        response <- map["response"]
    }
}
class Response :  Mappable {
    var periods = [DayWeather]()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        periods <- map["periods"]
    }
}

