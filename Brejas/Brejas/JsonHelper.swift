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
    
    func jsonFromString(_ string : String) -> AnyObject?{
        guard let stringData = string.data(using: String.Encoding.utf8) else {
            return nil
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: stringData, options: JSONSerialization.ReadingOptions(rawValue: 0))
            
            if let jsonDict = json as? [String : AnyObject] {
                return jsonDict as AnyObject?
            }else if let jsonArray = json as? [[String : AnyObject]] {
                return jsonArray as AnyObject?
            }else{
                return nil
            }
            
        }catch _ {
            return nil
        }
    }
    
}
