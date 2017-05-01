//
//  AutocompletionResponce.swift
//  Weather
//
//  Created by Vladislav Dorfman on 29/04/2017.
//  Copyright © 2017 Vladislav Dorfman. All rights reserved.
//

import Foundation
import ObjectMapper

class AutocompletionResponce :  Mappable{
  var results = [City]()
  
  //Impl. of Mappable protocol
  required convenience init?(map: Map) {
    self.init()
  }
  
  func mapping(map: Map) {
    results <- map["RESULTS"]
  }
}
