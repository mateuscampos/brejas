//
//  BeersCollectionViewDataSourceDelegate.swift
//  Brejas
//
//  Created by Mateus Campos on 02/07/17.
//  Copyright © 2017 Mateus Campos. All rights reserved.
//

import Foundation
import UIKit

typealias SelectedItem = (_ selectedItem: BeerModel) -> ()


protocol BeerDataSourceProtocol {
    func setBeerDataSource(beers: [BeerModel])
}

class BeersCollectionViewDataSourceDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, BeerDataSourceProtocol {
    
    private var beers: [BeerModel] = []
    private let selectionBlock: SelectedItem
    
    init(beers:[BeerModel] = [], selectedItem: @escaping SelectedItem) {
        self.selectionBlock = selectedItem
        self.beers = beers
    }
    
    func setBeerDataSource(beers: [BeerModel]) {
        self.beers = beers
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.beers.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeerCollectionViewCellIdentifier, for: indexPath) as! BeerCollectionViewCell
        
        cell.setupCell(beer: self.beers[indexPath.row])
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectionBlock(self.beers[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 250.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 0, bottom: 10.0, right: 0)
    }
    
}
