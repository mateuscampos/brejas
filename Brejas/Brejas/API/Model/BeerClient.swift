//
//  BeerClient.swift
//  Brejas
//
//  Created by mateus.campos on 10/04/2018.
//  Copyright © 2018 Mateus Campos. All rights reserved.
//

import Foundation

protocol BeerClientProtocol {
    func beers(onPage page:Int, callback: @escaping (Result<[BeerModel]>) -> Void)
}

class BeerClient: BeerClientProtocol {
    
    private let client: ApiClientProtocol
    
    init(client: ApiClientProtocol = ApiClient()) {
        self.client = client
    }
    
    func beers(onPage page:Int, callback: @escaping (Result<[BeerModel]>) -> Void) {
        
        let url = EnvironmentSetting().baseUrl! + Routes.beer.beers(forPage: page)
        
        self.client.request(url: url) { (data) in
            
            switch data {
                
                case let .success(data):
                    
                    Parser.parse(dataType: [BeerModel].self, from: data, callback: callback)
                
                case let .error(error):
                
                    callback(.error(error))
                
            }
            
        }
        
    }
    
}
