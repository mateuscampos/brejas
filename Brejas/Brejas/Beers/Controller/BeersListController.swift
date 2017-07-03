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
    
    var beersList: [BeerModel] = []
    var dataSourceDelegate: BeersCollectionViewDataSourceDelegate = BeersCollectionViewDataSourceDelegate()
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
        
        if self.beersList.count == 0 {
            self.beersList = beers
            self.dataSourceDelegate.beers = self.beersList
            self.collectionView.reloadData()
        } else {
            for beer in beers {
                let indexPath = IndexPath(item: self.beersList.count, section: 0)
                self.beersList.append(beer)
                self.dataSourceDelegate.beers = self.beersList
                self.collectionView.insertItems(at: [indexPath])
            }
        }
        self.collectionView.finishInfiniteScroll(completion: nil)
        self.refresher.endRefreshing()
        
    }
    
    func refreshBeers() {
        self.refresher.beginRefreshing()
        self.beersList.removeAll()
        self.page = 1
        self.loadBeers(page: self.page)
    }
    
    func handleTryAgain() {
        if self.page == 1 {
            self.loadBeers(page: self.page, loadingControl: true)
        } else {
            self.loadBeers(page: self.page)
        }
    }
    
    // MARK: - Request
    func loadBeers(page: Int, loadingControl: Bool = false) {
        
        if loadingControl {
            self.showLoading()
        }
        
        ApiClient.sharedApliClient.beers(onPage: page, success: { (beers) in
            
            self.hideLoading()
            
            if let list = beers as? [BeerModel] {
                self.updateScreen(withBeers: list)
            } else {
                self.showErrorAlert(withMessage: "Ocorreu algum erro equanto preparávamos as cervejas para você! :(") {
                    self.handleTryAgain()
                }
            }
        }) { (error) in
            self.hideLoading()
            
            self.showErrorAlert(withMessage: "Não foi possível carregar a lista de cervejas! :(") {
                self.handleTryAgain()
            }
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

        self.dataSourceDelegate.delegate = self
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
        self.navigationController?.pushViewController(BeersScreenBuilder.beerDetailController(beer: beer), animated: true)
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
