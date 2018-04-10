//
//  RequestHandler.swift
//  Brejas
//
//  Created by mateus.campos on 10/04/2018.
//  Copyright © 2018 Mateus Campos. All rights reserved.
//

import Foundation

protocol RequestHandlerProtocol {
    func handleRequestResponse(withResponse response: HTTPURLResponse?, andData data: Any?, success: Success, failure: Failure)
}

class RequestHandler: RequestHandlerProtocol {
    
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
