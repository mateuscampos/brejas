//
//  CollectionViewDataSourceDelegate.swift
//  Brejas
//
//  Created by Mateus Campos on 02/07/17.
//  Copyright © 2017 Mateus Campos. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewDataSourceDelegate<T: UICollectionViewCell & SetupableCell & ConfigurableCell>: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    typealias DataType = T.DataType
    private var data: [DataType] = []
    private let selectionBlock: SelectedItem
    typealias SelectedItem = (_ selectedItem: DataType) -> ()
    
    init(data:[DataType] = [], selectedItem: @escaping SelectedItem) {
        self.selectionBlock = selectedItem
        self.data = data
    }
    
    func setDataSource(data: [DataType]) {
        self.data = data
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.data.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: T.cellIdentifier, for: indexPath) as! T
        
        let data = self.data[indexPath.row]
        
        cell.setupCell(data: data)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectionBlock(self.data[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 250.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 0, bottom: 10.0, right: 0)
    }
    
}
