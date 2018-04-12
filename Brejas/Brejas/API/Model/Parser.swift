//
//  Parser.swift
//  Brejas
//
//  Created by mateus.campos on 12/04/2018.
//  Copyright © 2018 Mateus Campos. All rights reserved.
//

import Foundation

protocol ParserProtocol {
    
    static func parse<C>(dataType: C.Type, from data: Data, callback: @escaping (Result<C>) -> Void) where C: Codable
    
}

class Parser: ParserProtocol {

    static func parse<C>(dataType: C.Type, from data: Data, callback: @escaping (Result<C>) -> Void) where C: Codable {
        
        do {
            let parsedData = try JSONDecoder().decode(dataType, from: data)
            callback(.success(parsedData))
        } catch {
            callback(.error(error))
        }
        
    }
    
}
