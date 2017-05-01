//
//  City.swift
//  Weather
//
//  Created by Vladislav Dorfman on 28/04/2017.
//  Copyright © 2017 Vladislav Dorfman. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class City : Object, Mappable{
    dynamic var name = ""
    dynamic var lon = ""
    dynamic var lat = ""
    let forecast = List<DayWeather>()
    override static func primaryKey() -> String? {
        return "name"
    }
    
    //Impl. of Mappable protocol
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        lon <- map["lon"]
        lat <- map["lat"]
    }
}
