//
//  ObservationResponse.swift
//  Weather
//
//  Created by Vladislav Dorfman on 30/04/2017.
//  Copyright © 2017 Vladislav Dorfman. All rights reserved.
//

import Foundation
import ObjectMapper

class ObservationResponse :  Mappable {
  var success = false
  var response = ObservationResponseItem()
  
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
  var ob = Observation()
  
  required convenience init?(map: Map) {
    self.init()
  }
  
  func mapping(map: Map) {
    ob <- map["ob"]
  }
}
