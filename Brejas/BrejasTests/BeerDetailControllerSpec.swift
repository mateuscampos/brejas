//
//  BeerDetailControllerSpec.swift
//  Brejas
//
//  Created by Mateus Campos on 03/07/17.
//  Copyright © 2017 Mateus Campos. All rights reserved.
//

import Quick
import Nimble
import ObjectMapper

@testable import Brejas

class BeerDetailControllerSpec: QuickSpec {
    
    class MockBeerDetailController: BeerDetailController {
        
        var methodCalled = false
        
        override func viewDidLoad() {
            super.viewDidLoad()
            methodCalled = true
        }
        
    }
    
    override func spec() {
        
        describe("the BeersListController init") {
            
            it("has life cycle") {
                
                let controller = MockBeerDetailController()
                _ = controller.view
                expect(controller.methodCalled).to(beTruthy())
                
            }
            
            it("configure view") {
                
                let jsonData = JsonHelper.sharedInstance.jsonDataFromFile(BeerModelSpec.self, name: "BeerMock")
                let jsonString = String(data: jsonData, encoding: .utf8)
                let object: BeerModel = Mapper<BeerModel>().map(JSONString: jsonString!)!
                
                let controller = BeerDetailController()
                controller.fillBeerInfo(beer: object)
                
                expect(controller.beerDetailView.beerName.text).to(equal("Name: Buzz"))
                
                
            }
            
        }
        
    }
    
}
