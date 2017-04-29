//
//  API.swift
//  Weather
//
//  Created by Vladislav Dorfman on 29/04/2017.
//  Copyright © 2017 Vladislav Dorfman. All rights reserved.
//


import Foundation
import Alamofire
import AlamofireObjectMapper
import RealmSwift
import ObjectMapper
// MARK: NSObject

class API: NSObject {
    
    static let manager = Alamofire.SessionManager.default

    // MARK: URLRequestConvertible Enum
    // Defining request Router for handling URLRequests
    enum Router: URLRequestConvertible {
        
        case autocomplete(query : String)
        case forecast(latitude : String, longitude : String)
       
        //Defining parameters of URL Request for each API case
        //method parameter
        var method: HTTPMethod {
            switch self {
            default : return .get
            }
        }
        //path parameter
        var path: String {
            switch self {
            case .autocomplete:
                return Config.autocompleteURLString
            case .forecast:
                return Config.forecastURLString
            }
            
        }
        //headers parameter
        var headers: [String: String]? {
            switch self {
            default: return nil
            }
            
        }
        //parameters parameter
        var parameters: Parameters? {
            switch self {
            case .autocomplete(let query):
                return ["query" : query]
                case .forecast(let latitude, let longitude):
                return [
                    "client_id" : Config.forecast_client_id,
                    "client_secret" : Config.forecast_client_secret,
                    "p" : [latitude , longitude],
                    "limit" : Config.daysInForecast
                ]

            default: return nil
                
            }
        }
        
        
         // MARK: URLRequestConvertible
        func asURLRequest() throws -> URLRequest {      
            //Completing URL and URL suffixes
//            var urlString = ""
//            switch self {
//            case .autocomplete:
//                 urlString = Config.autocompleteURLString
//            case .forecast:
//                urlString = Config.forecastURLString
//            }
            let url = try path.asURL()
            var urlRequest = URLRequest(url: url)
            

            urlRequest.httpMethod = method.rawValue
            
            urlRequest.allHTTPHeaderFields = headers
            
            
            switch self {
            case .autocomplete:
                urlRequest = try URLEncoding.queryString.encode(urlRequest, with: parameters)
            default:
                break
            }
            return urlRequest
        }
        
    }
    

//MARK: API static methods:
    
    static func fetchAutocompletePredictions(query : String, success:@escaping ([City]) -> Void, fail:@escaping (_ error:NSError)->Void)->Void {
        API.manager.request(Router.autocomplete(query: query))
            .responseObject { (response : DataResponse<AutocompletionResponce>) in
                switch response.result {
                case .success(let results):
                    success(results.results)
                case .failure(let error) :
                    fail(error as NSError)
                }
        }
    }


static func fetchForecastData(latitude: String, longitude: String, success:@escaping ([DayWeather]) -> Void, fail:@escaping (_ error:NSError)->Void)->Void {
    API.manager.request(Router.forecast(latitude: latitude, longitude: longitude))
        .responseArray { (response : DataResponse<[City]>) in
            
//            switch response.result {
//            case .success(let items):
//                success(items)
//            case .failure(let error) :
//                fail(error as NSError)
//            }
            
            //                switch response.result {
            //                case .success(let item):
            //                    do {
            //                        let realm = try Realm()
            //                        try realm.write {
            //                            for item in items {
            //                                realm.add(item, update: true)
            //                            }
            //                        } catch let error as NSError {
            //                            fail(error:error)
            //                        }
            //                        success()
            //                case .failure(let error):
            //                        fail(error:error)
            //                    }
            //                    
            //                }
            
    }
}
}
