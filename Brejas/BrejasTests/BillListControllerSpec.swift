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
        
    }
    
    override func spec() {
        
        describe("the BeersListController init") {
            
            it("has life cycle") {
                
                let controller = MockBeerListController()
                _ = controller.view
                expect(controller.methodCalled).to(beTruthy())
                
            }
            
        }
        
    }
    
}
