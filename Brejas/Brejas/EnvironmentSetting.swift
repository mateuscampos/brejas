//
//  EnvironmentSetting.swift
//  Brejas
//
//  Created by Mateus Campos on 02/07/17.
//  Copyright © 2017 Mateus Campos. All rights reserved.
//

import Foundation


struct EnvironmentSetting {
    
    var enviroment:[String:AnyObject]? {
        get {
            if let env = Bundle.main.infoDictionary!["EnvironmentSetting"] as? [String : AnyObject] {
                return env
            } else {
                return nil
            }
        }
    }
    
    var baseUrl:String? {
        get {
            if let url = enviroment?["BASE_URL"] as? String{
                print(url)
                return url
            }else{
                return nil
            }
        }
    }
    
}
