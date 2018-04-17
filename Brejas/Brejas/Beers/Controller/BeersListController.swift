//
//  BeersListController.swift
//  Brejas
//
//  Created by Mateus Campos on 02/07/17.
//  Copyright © 2017 Mateus Campos. All rights reserved.
//

import Foundation
import UIKit

class BeersListController: UIViewController, ViewCodingProtocol {
    
    var beersList: [BeerModel]
    var dataSourceDelegate: CollectionViewDataSourceDelegate<BeerCollectionViewCell>?
    var collectionView: UICollectionView
    var page: Int
    var refresher: UIRefreshControl
    let client: BeerClientProtocol
    let beerFactory: BeerDataSourceFactory
    
    init(client: BeerClientProtocol = BeerClient(),
         page: Int = 1,
         beerFactory: BeerDataSourceFactory,
         beerList: [BeerModel] = [],
         collectionView: UICollectionView = BeersCollectionView(),
         refresher: UIRefreshControl = UIRefreshControl()) {
        
        self.client = client
        self.page = page
        self.beerFactory = beerFactory
        self.collectionView = beerFactory.collection
        self.dataSourceDelegate = beerFactory.dataSource()
        self.beersList = beerList
        self.collectionView = collectionView
        self.refresher = refresher
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            self.dataSourceDelegate?.setDataSource(data: self.beersList)
            self.collectionView.reloadData()
        } else {
            for beer in beers {
                let indexPath = IndexPath(item: self.beersList.count, section: 0)
                self.beersList.append(beer)
                self.dataSourceDelegate?.setDataSource(data: self.beersList)
                self.collectionView.insertItems(at: [indexPath])
            }
        }
        self.collectionView.finishInfiniteScroll(completion: nil)
        self.refresher.endRefreshing()
        
    }
    
    @objc func refreshBeers() {
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
        
        self.client.beers(onPage: page) { (data) in
            
            self.hideLoading()
            
            switch data {
            case let .success(beers):
                self.updateScreen(withBeers: beers)
            case .error:
                self.showErrorAlert(withMessage: "Ocorreu algum erro equanto preparávamos as cervejas para você! :(") {
                    self.handleTryAgain()
                }
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

        self.collectionView.addInfiniteScroll { (collection) in
            self.page+=1
            self.loadBeers(page: self.page)
        }
        
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
