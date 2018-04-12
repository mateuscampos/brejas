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
    func request(url: String, callback: @escaping (Result<Data>) -> Void)
}

class ApiClient: ApiClientProtocol {

    private let requestHandler: RequestHandlerProtocol
    
    init(requestHandler: RequestHandlerProtocol = RequestHandler()) {
        self.requestHandler = requestHandler
    }
    
    func request(url: String, callback: @escaping (Result<Data>) -> Void) {
        
        Alamofire.request(url).responseData { (response) in
            
            switch response.result {
                
            case let .success(data):
                
                self.requestHandler.handleRequestResponse(withResponse: response.response, andData: data, callback: callback)
                
            case let .failure (error):
                
                callback(.error(error))
                
            }
        }
        
    }

}

