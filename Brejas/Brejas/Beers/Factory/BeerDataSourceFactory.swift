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
    let collection: UICollectionView
    
    init(collection: UICollectionView = BeersCollectionView(),
         selectedItem: @escaping SelectedItem) {
        
        self.beerDataSource = BeersCollectionViewDataSourceDelegate(selectedItem: selectedItem)
        self.collection = collection
        self.collection.dataSource = beerDataSource
        self.collection.delegate = beerDataSource
        self.collection.register(BeerCollectionViewCell.self, forCellWithReuseIdentifier: BeerCollectionViewCellIdentifier)
        self.collection.reloadData()
        
    }
    
    func dataSource() -> BeerDataSourceProtocol {
        return self.beerDataSource
    }
    
}
