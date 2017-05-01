//
//  Constants.swift
//  Weather
//
//  Created by Vladislav Dorfman on 28/04/2017.
//  Copyright © 2017 Vladislav Dorfman. All rights reserved.
//

import Foundation
import RealmSwift
import KeychainSwift
struct Config {
  
  //MARK: - Strings constants
  
  static let dateFormat = "yyyy-MM-dd'T'HH:mm:ssxxxxx"
  
  static let autocompleteURLString = "http://autocomplete.wunderground.com/aq"
  
  static let forecastURLString = "https://api.aerisapi.com//forecasts/"
  static let observationURLString = "https://api.aerisapi.com//observations/"
  static let aeris_client_id = "78fKKT6trlh0XmOnWkY7A"
  static let aeris_client_secret = "Ttk2Emd7tfVdvwqyh8uJZwWf3p8JrVjKCG8Ubumo"
  
  //MARK: - Keychain stored constants
  static let daysInForecastDefault = "5"
  static var daysInForecast : String {
    get {
      return keyChainer.get("daysInForecast") ?? daysInForecastDefault
    }
    set (newValue){
      keyChainer.set(newValue, forKey: "daysInForecast")
    }
  }
  fileprivate static let keyChainer : KeychainSwift = {
    let keychain = KeychainSwift()
    
    return keychain
  }()
  
}
