//
//  BeerDetailController.swift
//  Brejas
//
//  Created by Mateus Campos on 02/07/17.
//  Copyright © 2017 Mateus Campos. All rights reserved.
//

import Foundation
import UIKit

class BeerDetailController: UIViewController, ViewCodingProtocol {
    
    var containerView: UIView = UIView()
    var beer: BeerModel?
    var beerDetailView: BeerDetailView = BeerDetailView()
    
    convenience init(beer: BeerModel) {
        self.init(nibName:nil, bundle:nil)
        self.beer = beer
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detalhes"
        self.setupViewConfiguration()
        if let beer = self.beer {
            self.fillBeerInfo(beer: beer)
        }
    }
    
    
    // MARK: - Actions
    
    func fillBeerInfo(beer: BeerModel) {
        self.beerDetailView.setupInfo(forBeer: beer)
    }
    
    // MARK: - ViewCodingProtocol
    func buildViewHierarchy() {
        self.view.addSubview(self.beerDetailView)
    }
    
    func setupConstraints() {
        self.beerDetailView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
        }
    }
    
}


