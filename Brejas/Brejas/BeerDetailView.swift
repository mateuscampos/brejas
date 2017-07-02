//
//  BeerDetailView.swift
//  Brejas
//
//  Created by Mateus Campos on 02/07/17.
//  Copyright © 2017 Mateus Campos. All rights reserved.
//

import Foundation
import UIKit

class BeerDetailLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont(name: "System", size: 20.0)
        self.textColor = .black
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BeerDetailView: UIScrollView, ViewCodingProtocol {
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let beerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()
    
    let beerName = BeerDetailLabel()
    let beerTagline = BeerDetailLabel()
    let beerDescription = BeerDetailLabel()
    let beerAbv = BeerDetailLabel()
    let beerIbu = BeerDetailLabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViewConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    func setupInfo(forBeer beer: BeerModel) {
        self.loadImage(fromUrl: beer.beerImageUrl!)
        self.beerName.text = "Name: \(beer.beerName!)"
        self.beerTagline.text = "Tagline: \(beer.beerTagline!)"
        self.beerDescription.text = "Description: \(beer.beerDescription!)"
        self.beerAbv.text = "ABV: \(NSString(format: "%.2f", beer.beerAbv!))"
        self.beerIbu.text = "IBU: \(NSString(format: "%.2f", beer.beerIbu!))"
    }
    
    func loadImage(fromUrl url: String) {
        
        self.beerImageView.af_setImage(
            withURL: URL(string: url)!,
            placeholderImage: UIImage(named: "beer_placeholder")
        )
        
    }
    
    // MARK: - ViewCodingProtocol
    func buildViewHierarchy() {
        self.addSubview(self.containerView)
        self.containerView.addSubview(self.beerImageView)
        self.containerView.addSubview(self.beerName)
        self.containerView.addSubview(self.beerTagline)
        self.containerView.addSubview(self.beerDescription)
        self.containerView.addSubview(self.beerAbv)
        self.containerView.addSubview(self.beerIbu)
    }
    
    func configureViews() {
        self.backgroundColor = .white
    }
    
    func setupConstraints() {
        
        self.containerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.greaterThanOrEqualTo(50.0)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        self.beerImageView.snp.makeConstraints { (make) in
            make.height.equalTo(250.0)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.top.equalTo(self.containerView.snp.top).offset(20.0)
        }
        self.beerName.snp.makeConstraints { (make) in
            make.height.greaterThanOrEqualTo(20.0)
            make.left.equalTo(self.containerView.snp.left).offset(20.0)
            make.right.equalTo(self.containerView.snp.right).inset(20.0)
            make.top.equalTo(self.beerImageView.snp.bottom).offset(20.0)
        }
        self.beerTagline.snp.makeConstraints { (make) in
            make.height.greaterThanOrEqualTo(20.0)
            make.left.equalTo(self.containerView.snp.left).offset(20.0)
            make.right.equalTo(self.containerView.snp.right).inset(20.0)
            make.top.equalTo(self.beerName.snp.bottom).offset(10.0)
        }
        self.beerDescription.snp.makeConstraints { (make) in
            make.height.greaterThanOrEqualTo(20.0)
            make.left.equalTo(self.containerView.snp.left).offset(20.0)
            make.right.equalTo(self.containerView.snp.right).inset(20.0)
            make.top.equalTo(self.beerTagline.snp.bottom).offset(10.0)
        }
        self.beerAbv.snp.makeConstraints { (make) in
            make.height.greaterThanOrEqualTo(20.0)
            make.left.equalTo(self.containerView.snp.left).offset(20.0)
            make.right.equalTo(self.containerView.snp.right).inset(20.0)
            make.top.equalTo(self.beerDescription.snp.bottom).offset(10.0)
        }
        self.beerIbu.snp.makeConstraints { (make) in
            make.height.greaterThanOrEqualTo(20.0)
            make.left.equalTo(self.containerView.snp.left).offset(20.0)
            make.right.equalTo(self.containerView.snp.right).inset(20.0)
            make.top.equalTo(self.beerAbv.snp.bottom).offset(10.0)
            make.bottom.equalTo(self.containerView.snp.bottom).inset(10.0)
        }
    }
    
}
