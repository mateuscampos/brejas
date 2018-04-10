//
//  ApiClient.swift
//  Brejas
//
//  Created by Mateus Campos on 30/06/17.
//  Copyright © 2017 Mateus Campos. All rights reserved.
//

import Foundation
import Alamofire

typealias Failure = (_ error: Any?) -> ()
typealias Success = (_ response: Any?) -> ()

protocol ApiClientProtocol {
    func request(url: String, success: @escaping Success, failure: @escaping Failure)
}

class ApiClient: ApiClientProtocol {

    private let requestHandler: RequestHandlerProtocol
    
    init(requestHandler: RequestHandlerProtocol = RequestHandler()) {
        self.requestHandler = requestHandler
    }
    
    func request(url: String, success: @escaping Success, failure: @escaping Failure) {
        
        Alamofire.request(url).responseJSON { (response) in
            
            switch response.result {
                
            case let .success(data):
                self.requestHandler.handleRequestResponse(withResponse: response.response, andData: data, success: { (response) in
                    success(data)
                }, failure: { (error) in
                    failure(ErrorResult(errorNumber: response.response?.statusCode ?? 999, errorDescription: "Could not retrieve the beers"))
                })
            case .failure:
                failure(ErrorResult(errorNumber: 999, errorDescription: "Could not retrieve the beers"))
            }
        }
        
    }

}

