//
//  BeerDataSourceFactory.swift
//  Brejas
//
//  Created by mateus.campos on 10/04/2018.
//  Copyright © 2018 Mateus Campos. All rights reserved.
//

import Foundation

class BeerDataSourceFactory {
    
    typealias SelectedBeer = (_ selectedItem: BeerModel) -> ()
    
    private var beerDataSource: BeersCollectionViewDataSourceDelegate<BeerCollectionViewCell>
    let collection: UICollectionView
    
    init(collection: UICollectionView = BeersCollectionView(),
         selectedItem: @escaping SelectedBeer) {
        
        self.beerDataSource = BeersCollectionViewDataSourceDelegate(selectedItem: selectedItem)
        self.collection = collection
        self.collection.dataSource = beerDataSource
        self.collection.delegate = beerDataSource
        self.collection.register(BeerCollectionViewCell.self, forCellWithReuseIdentifier: BeerCollectionViewCell.cellIdentifier)
        self.collection.reloadData()
        
    }
    
    func dataSource() -> BeersCollectionViewDataSourceDelegate<BeerCollectionViewCell> {
        return self.beerDataSource
    }
    
}
