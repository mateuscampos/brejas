//
//  BeerCollectionViewCell.swift
//  Brejas
//
//  Created by Mateus Campos on 02/07/17.
//  Copyright © 2017 Mateus Campos. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SnapKit

let BeerCollectionViewCellIdentifier = "BeerCollectionViewCellIdentifier"

class BeerCollectionViewCell: UICollectionViewCell, ViewCodingProtocol {
    
    let beerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 3.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let backAlphaView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.65)
        view.layer.cornerRadius = 3.0
        view.layer.masksToBounds = true
        return view
    }()
    
    let beerName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "System", size: 20.0)
        lbl.textColor = .white
        return lbl
    }()
    
    let beerAbv: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "System", size: 20.0)
        lbl.textColor = .white
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.clipsToBounds = true
        self.setupViewConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.beerImageView.af_cancelImageRequest()
        self.beerImageView.layer.removeAllAnimations()
        self.beerImageView.image = nil
        self.beerName.text = nil
        self.beerAbv.text = nil
    }
    
    // MARK: - Setup cell
    
    func setupCell(beer: BeerModel) {
        
        self.alpha = 0
        UIView.animate(withDuration: 0.3) { 
            self.alpha = 1
        }
        
        self.loadImage(fromUrl: beer.beerImageUrl!)
        self.beerName.text = beer.beerName
        self.beerAbv.text = "ABV: \(NSString(format: "%.2f", beer.beerAbv!))"
    }
    
    func loadImage(fromUrl url: String) {
        
        self.beerImageView.af_setImage(
            withURL: URL(string: url)!,
            placeholderImage: UIImage(named: "beer_placeholder")
        )
        
    }
    
    
    // MARK: - ViewCodingProtocol
    
    func buildViewHierarchy() {
        self.contentView.addSubview(self.beerImageView)
        self.backAlphaView.addSubview(self.beerName)
        self.backAlphaView.addSubview(self.beerAbv)
        self.contentView.addSubview(self.backAlphaView)
    }
    
    func setupConstraints() {
        
        self.contentView.snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.main.bounds.size.width)
            make.height.equalTo(250.0)
            make.leading.equalTo(0)
            make.top.equalTo(0)
        }
        
        self.beerImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalTo(self.contentView.snp.left).offset(10.0)
            make.right.equalTo(self.contentView.snp.right).inset(10.0)
        }
        
        self.backAlphaView.snp.makeConstraints { (make) in
            make.height.equalTo(70.0)
            make.bottom.equalTo(self.contentView.snp.bottom).inset(0.0)
            make.left.equalTo(self.contentView.snp.left).offset(10.0)
            make.right.equalTo(self.contentView).inset(10.0)
        }
        
        self.beerName.snp.makeConstraints { (make) in
            make.height.equalTo(20.0)
            make.top.equalTo(self.backAlphaView.snp.top).offset(10.0)
            make.left.equalTo(self.backAlphaView.snp.left).offset(10.0)
            make.right.equalTo(self.backAlphaView.snp.right).inset(10.0)
        }
        
        self.beerAbv.snp.makeConstraints { (make) in
            make.height.equalTo(20.0)
            make.top.equalTo(self.beerName.snp.bottom).offset(10.0)
            make.left.equalTo(self.backAlphaView.snp.left).offset(10.0)
            make.right.equalTo(self.backAlphaView.snp.right).inset(10.0)
            make.bottom.equalTo(self.backAlphaView.snp.bottom).inset(10.0)
        }
        
    }
    
}
