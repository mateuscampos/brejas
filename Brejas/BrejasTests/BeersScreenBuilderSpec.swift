//
//  BeersScreenBuilderSpec.swift
//  Brejas
//
//  Created by Mateus Campos on 02/07/17.
//  Copyright © 2017 Mateus Campos. All rights reserved.
//

import Quick
import Nimble
import ObjectMapper

@testable import Brejas

class BeersScreenBuilderSpec: QuickSpec {
    
    override func spec() {
        
        describe("the ScreenBuilder parser") {
            
            it("has to instantiate beers list controller") {
                
                let nav = BeersScreenBuilder.beersListController()
                let controller = nav.viewControllers.first
                
                expect(nav).to(beAnInstanceOf(UINavigationController.self))
                expect(controller).to(beAnInstanceOf(BeersListController.self))
                
            }
            
            it("has to instantiate beers detail controller") {
                
//                let jsonData = JsonHelper.sharedInstance.jsonDataFromFile(BeerModelSpec.self, name: "BeerMock")
//                let jsonString = String(data: jsonData, encoding: .utf8)
//                let object: BeerModel = Mapper<BeerModel>().map(JSONString: jsonString!)!
                
                let controller = BeersScreenBuilder.beerDetailCOntroller()
                
                expect(controller).to(beAnInstanceOf(BeerDetailController.self))
                
            }
            
        }
        
    }
    
}
