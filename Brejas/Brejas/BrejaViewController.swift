//
//  BrejaViewController.swift
//  Brejas
//
//  Created by Mateus Campos on 30/06/17.
//  Copyright © 2017 Mateus Campos. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class BrejaViewController: UIViewController, ViewCodingProtocol {
    
    let containerView: UIView = UIView()
    var beers: Array<BeerModel>?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewConfiguration()
        
        ApiClient.sharedApliClient.beers(onPage: 1, success: { (beers) in
            
            self.beers = beers as? [BeerModel]
            
            print(self.beers)
        }) { (error) in
            print(error)
        }
        
    }
    
    // MARK: - ViewCodingProtocol
    func setupConstraints() {
        self.containerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    func buildViewHierarchy() {
        self.view.addSubview(self.containerView)
    }
    
    func configureViews() {
        self.title = "Cervejas"
        self.containerView.backgroundColor = UIColor.brown
    }
    
}
