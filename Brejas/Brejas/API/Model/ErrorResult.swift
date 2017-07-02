//
//  ErrorResult.swift
//  Brejas
//
//  Created by Mateus Campos on 30/06/17.
//  Copyright © 2017 Mateus Campos. All rights reserved.
//

import Foundation

struct ErrorResult {
    
    var errorNumber: Int
    var errorDescription: String
    
    init(errorNumber: Int, errorDescription: String) {
        self.errorNumber = errorNumber
        self.errorDescription = errorDescription
    }
    
}
