//
//  BeersListController.swift
//  Brejas
//
//  Created by Mateus Campos on 02/07/17.
//  Copyright © 2017 Mateus Campos. All rights reserved.
//

import Foundation
import UIKit

class BeersListController: UIViewController, ViewCodingProtocol, BeerListViewDelegate {
    
    var beers: [BeerModel] = []
    var dataSourceDelegate: BeersCollectionViewDataSourceDelegate?
    var collectionView: UICollectionView = BeersCollectionView()
    var page: Int = 1
    var refresher: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewConfiguration()
        self.setupCollectionView()
        self.loadBeers(page: self.page, loadingControl: true)
        self.title = "Cervejas"
    }
    
    // MARK: - Action
    func updateScreen(withBeers beers: [BeerModel]) {
        
        for beer in beers {
            let indexPath = IndexPath(item: self.beers.count, section: 0)
            self.beers.append(beer)
            self.dataSourceDelegate?.beers = self.beers
            self.collectionView.insertItems(at: [indexPath])
        }

        self.collectionView.finishInfiniteScroll(completion: nil)
        self.refresher.endRefreshing()
    }
    
    func refreshBeers() {
        self.refresher.beginRefreshing()
        self.beers.removeAll()
        self.page = 1
        self.loadBeers(page: self.page)
    }
    
    func showErrorAlert(withMessage message: String) {
        
        let alertController: UIAlertController = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let tryAgainAction: UIAlertAction = UIAlertAction(title: "Tentar Novamente", style: .default) { (action) in
            if self.page == 1 {
                self.loadBeers(page: self.page, loadingControl: true)
            } else {
                self.loadBeers(page: self.page)
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(tryAgainAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    // MARK: - Request
    func loadBeers(page: Int, loadingControl: Bool = false) {
        
        if loadingControl {
            self.showLoading()
        }
        
        ApiClient.sharedApliClient.beers(onPage: page, success: { (beers) in
            if let list = beers as? [BeerModel] {
                self.updateScreen(withBeers: list)
            }
            self.hideLoading()
        }) { (error) in
            self.hideLoading()
            self.showErrorAlert(withMessage: "Não foi possível carregar a lista de cervejas! :(")
        }
    }
    
    // MARK: - Setup
    
    func setupCollectionView() {
        
        self.refresher.addTarget(self, action: #selector(refreshBeers), for: .valueChanged)
        self.collectionView.alwaysBounceVertical = true
        if #available(iOS 10.0, *) {
            self.collectionView.refreshControl = self.refresher
        } else {
            self.collectionView.addSubview(self.refresher)
        }

        self.dataSourceDelegate = BeersCollectionViewDataSourceDelegate(beerListDelegate: self)
        self.collectionView.delegate = self.dataSourceDelegate
        self.collectionView.dataSource = self.dataSourceDelegate
        self.collectionView.register(BeerCollectionViewCell.self, forCellWithReuseIdentifier: BeerCollectionViewCellIdentifier)
        self.collectionView.reloadData()
        
        self.collectionView.addInfiniteScroll { (collection) in
            self.page+=1
            self.loadBeers(page: self.page)
        }
        
    }
    
    // MARK: - BeersCollectionViewDataSourceDelegate
    
    func didSelectedBeer(beer: BeerModel) {
        self.navigationController?.pushViewController(BeersScreenBuilder.beerDetailCOntroller(beer: beer), animated: true)
    }
    
    // MARK: - ViewCodingProtocol
    
    func buildViewHierarchy() {
        self.view.addSubview(self.collectionView)
    }
    
    func setupConstraints() {
        self.collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
}
