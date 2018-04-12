//
//  BeerClient.swift
//  Brejas
//
//  Created by mateus.campos on 10/04/2018.
//  Copyright © 2018 Mateus Campos. All rights reserved.
//

import Foundation

protocol BeerClientProtocol {
    func beers(onPage page:Int, success: @escaping Success, failure: @escaping Failure)
}

class BeerClient: BeerClientProtocol {
    
    private let client: ApiClientProtocol
    
    init(client: ApiClientProtocol = ApiClient()) {
        self.client = client
    }
    
    func beers(onPage page:Int, success: @escaping Success, failure: @escaping Failure) {
        
        let url = EnvironmentSetting().baseUrl! + Routes.beer.beers(forPage: page)
        
        self.client.request(url: url, success: { data in
            
            guard let data = data as? Data else {
                failure(ErrorResult(errorNumber: 999, errorDescription: "Error parsing data from server"))
                return
            }
            
            if let object = try? JSONDecoder().decode([BeerModel].self, from: data) {
                success(object)
            } else {
                failure(ErrorResult(errorNumber: 999, errorDescription: "Error parsing data from server"))
            }
            
        }) { error in
            failure(error)
        }
        
    }
    
}
