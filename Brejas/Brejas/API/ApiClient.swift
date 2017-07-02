//
//  ApiClient.swift
//  Brejas
//
//  Created by Mateus Campos on 30/06/17.
//  Copyright © 2017 Mateus Campos. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

enum Routes: String {
    
    case beer
    
    func beers(forPage page: Int) -> String {
        switch self {
        case .beer:
            return "beers?page=\(page)"
        }
    }
    
}

typealias Failure = (_ error: Any?) -> ()
typealias Success = (_ response: Any?) -> ()

class ApiClient {
    
    static let sharedApliClient = ApiClient()
    
    func beers(onPage page:Int, success: @escaping Success, failure: @escaping Failure) {
        
        let url = EnvironmentSetting().baseUrl! + Routes.beer.beers(forPage: page)
        
        Alamofire.request(url).responseJSON { (response) in
            
            switch response.result {

            case let .success(data):
                
                self.handleRequestResponse(withResponse: response.response, andData: data, success: { (response) in
                    
                    if let object = Mapper<BeerModel>().mapArray(JSONObject: response) {
                        success(object)
                    } else {
                        failure(ErrorResult(errorNumber: 999, errorDescription: "Error parsing data from server"))
                    }
                    
                }, failure: { (error) in
                    
                })
                
            case .failure:
                
                failure(ErrorResult(errorNumber: 999, errorDescription: "Could not retrieve the beers"))
                
            }
        }
    }
}


extension ApiClient {
    
    func handleRequestResponse(withResponse response: HTTPURLResponse?, andData data: Any?, success: Success, failure: Failure) {
        
        if let statusCode = response?.statusCode {
            switch statusCode {
            case 200...209:
                success(data)
            default:
                failure(ErrorResult(errorNumber: statusCode, errorDescription: "Could not retrieve the beers"))
            }
        }
    }
    
}
