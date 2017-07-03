//
//  BeerModelSpec.swift
//  Brejas
//
//  Created by Mateus Campos on 02/07/17.
//  Copyright © 2017 Mateus Campos. All rights reserved.
//

import Quick
import Nimble
import ObjectMapper

@testable import Brejas

class BeerModelSpec: QuickSpec {
    
    override func spec() {
        
        describe("the BeerModel parser") {
            
            it("has json file") {
                
                let jsonData = JsonHelper.sharedInstance.jsonDataFromFile(BeerModelSpec.self, name: "BeerMock")
                let jsonString = String(data: jsonData, encoding: .utf8)
                let object: BeerModel = Mapper<BeerModel>().map(JSONString: jsonString!)!
                
                expect(object).toNot(beNil())
    
            }
            
        }
        
    }
    
}
