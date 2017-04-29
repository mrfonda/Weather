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

//protocol URLRequestable {
//    static func urlRequest() -> URLRequest
//}

class City : Object, Mappable{
    dynamic var name = ""
    dynamic var lon = ""
    dynamic var lat = ""
    
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



//"name": "Ashgabat, Turkmenistan",
//"type": "city",
//"c": "TM",
//"zmw": "00000.113.38880",
//"tz": "Asia/Ashgabat",
//"tzs": "+05",
//"l": "/q/zmw:00000.113.38880",
//"ll": "37.950001 58.380001",
//"lat": "37.950001",
//"lon": "58.380001"
