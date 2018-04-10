//
//  ApiRoutes.swift
//  Brejas
//
//  Created by mateus.campos on 10/04/2018.
//  Copyright © 2018 Mateus Campos. All rights reserved.
//

import Foundation

enum Routes: String {
    
    case beer
    
    func beers(forPage page: Int) -> String {
        switch self {
        case .beer:
            return "beers?page=\(page)"
        }
    }
    
}
