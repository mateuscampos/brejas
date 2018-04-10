//
//  BeerDataSourceFactory.swift
//  Brejas
//
//  Created by mateus.campos on 10/04/2018.
//  Copyright © 2018 Mateus Campos. All rights reserved.
//

import Foundation

class BeerDataSourceFactory {
    
    private var beerDataSource: BeersCollectionViewDataSourceDelegate
    private let collection: UICollectionView
    
    init(collection: UICollectionView, delegate: BeerListViewDelegate) {
        self.beerDataSource = BeersCollectionViewDataSourceDelegate(delegate: delegate)
        self.collection = collection
        self.collection.dataSource = beerDataSource
        self.collection.delegate = beerDataSource
    }
    
    func dataSource() -> BeerDataSourceProtocol {
        return self.beerDataSource
    }
    
}
