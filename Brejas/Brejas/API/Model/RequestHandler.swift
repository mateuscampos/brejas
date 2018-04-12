//
//  RequestHandler.swift
//  Brejas
//
//  Created by mateus.campos on 10/04/2018.
//  Copyright © 2018 Mateus Campos. All rights reserved.
//

import Foundation

protocol RequestHandlerProtocol {
    func handleRequestResponse(withResponse response: HTTPURLResponse?, andData data: Data, callback: (Result<Data>) -> Void)
}

class RequestHandler: RequestHandlerProtocol {
    
    func handleRequestResponse(withResponse response: HTTPURLResponse?, andData data: Data, callback: (Result<Data>) -> Void) {
        
        if let statusCode = response?.statusCode {
            switch statusCode {
            case 200...209:
                callback(.success(data))
            default:
                let error = NSError(domain: "RequestError", code: statusCode, userInfo: [NSLocalizedDescriptionKey: HTTPURLResponse.localizedString(forStatusCode: statusCode)])
                callback(.error(error))
            }
        }
    }
    
}
