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

class ErrorResultSpec: QuickSpec {
    
    override func spec() {
        
        describe("the ErrorResult parser") {
            
            it("has initialization") {
                
                let object: ErrorResult = ErrorResult(errorNumber: 999, errorDescription: "Test String")
                
                expect(object).to(beAKindOf(ErrorResult.self))
                expect(object.errorNumber).to(equal(999))
                expect(object.errorNumber).to(beAKindOf(Int.self))
                expect(object.errorDescription).to(equal("Test String"))
                expect(object.errorDescription).to(beAKindOf(String.self))
                
            }
            
        }
        
    }
    
}
