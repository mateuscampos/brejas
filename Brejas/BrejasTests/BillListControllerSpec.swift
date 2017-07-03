//
//  ErrorResultSpec.swift
//  Brejas
//
//  Created by Mateus Campos on 02/07/17.
//  Copyright © 2017 Mateus Campos. All rights reserved.
//

import Quick
import Nimble
import ObjectMapper

@testable import Brejas

class BillListControllerSpec: QuickSpec {
    
    class MockBeerListController: BeersListController {
        
        var methodCalled = false
        
        override func viewDidLoad() {
            super.viewDidLoad()
            methodCalled = true
        }
        
        override func didSelectedBeer(beer: BeerModel) {
            super.didSelectedBeer(beer: beer)
            methodCalled = true
        }
        
    }
    
    override func spec() {
        
        describe("the BeersListController init") {
            
            let controller = MockBeerListController()
            
            beforeEach {
                controller.methodCalled = false
            }
            
            it("has life cycle") {

                _ = controller.view
                expect(controller.methodCalled).to(beTruthy())
                
            }
            
            it("should update layout") {
                
                let controller = BeersListController()
                let jsonData = JsonHelper.sharedInstance.jsonDataFromFile(BeersCollectionViewDataSourceDelegateSpec.self, name: "ResponseMock")
                let jsonString = String(data: jsonData, encoding: .utf8)
                let beers = Mapper<BeerModel>().mapArray(JSONString: jsonString!)!
                
                controller.updateScreen(withBeers: beers)
                
                expect(controller.beersList.count).to(equal(beers.count))
                
            }
            
            it("should call detail") {
                
                let jsonData = JsonHelper.sharedInstance.jsonDataFromFile(BeerModelSpec.self, name: "BeerMock")
                let jsonString = String(data: jsonData, encoding: .utf8)
                let object: BeerModel = Mapper<BeerModel>().map(JSONString: jsonString!)!
                
                let controller = MockBeerListController()
                controller.didSelectedBeer(beer: object)
                
                expect(controller.methodCalled).to(beTruthy())

            }
            
        }
        
    }
    
}
