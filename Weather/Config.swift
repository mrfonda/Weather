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
    
    static let googleAPIKey = "AIzaSyCVGsWOZYPWfvGONDgV6hJZijXJQ-Ck9NM"
    static let dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    static let autocompleteURLString = "http://autocomplete.wunderground.com/aq"
    static let autocompleteURL = NSURL(string: autocompleteURLString)!
    


    
    static let forecastURLString = "https://api.aerisapi.com//forecasts/"
    static let forecastURL = NSURL(string: forecastURLString)!
    static let forecast_client_id = "78fKKT6trlh0XmOnWkY7A"
    static let forecast_client_secret = "Ttk2Emd7tfVdvwqyh8uJZwWf3p8JrVjKCG8Ubumo"

   
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
