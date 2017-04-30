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
    static let realm = try! Realm()
    // MARK: URLRequestConvertible Enum
    // Defining request Router for handling URLRequests
    enum Router: URLRequestConvertible {
        
        case autocomplete(query : String)
        case forecast(latitude : String, longitude : String)
        case observation(latitude : String, longitude : String)
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
            case .observation:
                return Config.observationURLString
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
                    "client_id" : Config.aeris_client_id,
                    "client_secret" : Config.aeris_client_secret,
                    "p" : "\(latitude),\(longitude)",
                    "limit" : Config.daysInForecast
                ]
            case  .observation(let latitude, let longitude):
                return [
                    "client_id" : Config.aeris_client_id,
                    "client_secret" : Config.aeris_client_secret,
                    "p" : "\(latitude),\(longitude)",
                    "limit" : 1
                ]
            default: return nil
                
            }
        }
        
        
         // MARK: URLRequestConvertible
        func asURLRequest() throws -> URLRequest {      
            //Completing URL and URL suffixes
            //Simple version with full path
            let url = try path.asURL()
            var urlRequest = URLRequest(url: url)
            

            urlRequest.httpMethod = method.rawValue
            
            urlRequest.allHTTPHeaderFields = headers
            
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: parameters)

            print(urlRequest)
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


    static func fetchForecastData(city: City, success:@escaping () -> Void, fail:@escaping (_ error:NSError)->Void, updateProgress : @escaping (_ progress : Float)->Void)->Void {
        API.manager.request(Router.forecast(latitude: city.lat, longitude: city.lon))
            .downloadProgress(closure: { (progress: Progress) in
                updateProgress(Float(progress.fractionCompleted))
            })
            .responseObject { (response : DataResponse<ForecastResponce>)  in
                
                switch response.result {
                case .success(let forecastResponse):
                    if forecastResponse.success {
                        try! realm.write {
                            if !city.forecast.isEmpty {
                                city.forecast.removeAll()
                            }
                            city.forecast.append(objectsIn: forecastResponse.response[0].periods) //List((days[0].periods))
                            realm.add(city, update: true)
                        }
                        
                        success()
                    }
                case .failure(let error) :
                    fail(error as NSError)
                }
                
        }
    }
    static func fetchObservationData(city: City, success:@escaping (Observation) -> Void, fail:@escaping (_ error:NSError)->Void)->Void {
        API.manager.request(Router.observation(latitude: city.lat, longitude: city.lon))
            .responseObject { (response : DataResponse<ObservationResponse>)  in
                
                switch response.result {
                case .success(let observationResponse):
                    if observationResponse.success {
                        success(observationResponse.response.ob)
                    } else {fail(NSError())}
                case .failure(let error) :
                    fail(error as NSError)
                }
                
        }
    }
}
