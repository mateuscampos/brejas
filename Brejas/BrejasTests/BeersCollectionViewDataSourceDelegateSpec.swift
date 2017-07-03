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

class BeersCollectionViewDataSourceDelegateSpec: QuickSpec {
    
    class MockBeersCollectionViewDataSourceDelegate: BeersCollectionViewDataSourceDelegate {
        
        var methodCalled: Bool = false
        
        override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            super.collectionView(collectionView, didSelectItemAt: indexPath)
            methodCalled = true
        }
        
        override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            _ = super.collectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)
            methodCalled = true
            return .zero
        }
        
        override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            _ = super.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: section)
            methodCalled = true
            return .zero
        }
        
    }
    
    override func spec() {
        
        describe("the BeersCollectionViewDataSourceDelegate") {
            
            let beers: [BeerModel] = []
            let dataSource: BeersCollectionViewDataSourceDelegate = BeersCollectionViewDataSourceDelegate()
            let mockDataSource = MockBeersCollectionViewDataSourceDelegate()
            let collectioView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
            
            beforeEach {
//                let jsonData = JsonHelper.sharedInstance.jsonDataFromFile(BeersCollectionViewDataSourceDelegateSpec.self, name: "ResponseMock")
//                let jsonString = String(data: jsonData, encoding: .utf8)
//                let beers = Mapper<BeerModel>().mapArray(JSONString: jsonString!)!
//                dataSource.beers = beers
                mockDataSource.methodCalled = false
                collectioView.register(BeerCollectionViewCell.self, forCellWithReuseIdentifier: BeerCollectionViewCellIdentifier)
            }
            
            it("has to initialize") {

                expect(dataSource).toNot(beNil())
                expect(dataSource).to(beAKindOf(BeersCollectionViewDataSourceDelegate.self))
                
            }
            
            it("should return number of rows") {
                let numberOfRows = beers.count
                expect(dataSource.collectionView(collectioView, numberOfItemsInSection: 0)).to(equal(numberOfRows))
            }
            
            it("should return a cell") {
                //expect(dataSource.collectionView(collectioView, cellForItemAt: IndexPath(row: 0, section: 0))).to(beAnInstanceOf(BeerCollectionViewCell.self))
            }
            
            it("should trigger selection") {
                _ = mockDataSource.collectionView(collectioView, didSelectItemAt: IndexPath(row: 0, section: 0))
                expect(mockDataSource.methodCalled).to(beTruthy())
            }
            
            it("should set item size") {
                _ = mockDataSource.collectionView(collectioView, layout: UICollectionViewLayout(), sizeForItemAt: IndexPath(row: 0, section: 0))
                expect(mockDataSource.methodCalled).to(beTruthy())
            }
            
            it("should set instet") {
                _ = mockDataSource.collectionView(collectioView, layout: UICollectionViewLayout(), insetForSectionAt: 0)
                expect(mockDataSource.methodCalled).to(beTruthy())
            }
            
        }
        
    }
    
}
