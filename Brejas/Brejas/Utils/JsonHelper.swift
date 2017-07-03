//
//  JsonHelper.swift
//  Brejas
//
//  Created by Mateus Campos on 02/07/17.
//  Copyright © 2017 Mateus Campos. All rights reserved.
//

import Foundation


class JsonHelper: NSObject {
    
    static let sharedInstance = JsonHelper()
    
    func jsonDataFromFile(_ className: AnyClass, name: String) -> Foundation.Data {
        
        if let masterDataUrl: URL = Bundle(for: className).url(forResource: name, withExtension: "json") {
            
            if let dataFromFile = try? Foundation.Data(contentsOf: masterDataUrl) {
                return dataFromFile
                
            } else {
                return Foundation.Data()
            }
        } else {
            return Foundation.Data()
        }
    }
    
}
