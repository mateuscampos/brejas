//
//  LoadingView.swift
//  Brejas
//
//  Created by Mateus Campos on 02/07/17.
//  Copyright © 2017 Mateus Campos. All rights reserved.
//

import Foundation
import UIKit

protocol Loadable {
    var activityIndicatorView: LoadingView { get }
}

class LoadingView: UIView, ViewCodingProtocol {
    
    static let viewInstance: LoadingView = LoadingView()
    
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViewConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewCodingProtocol
    func setupConstraints() {
        
        self.indicator.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func buildViewHierarchy() {
        self.addSubview(self.indicator)
    }
    
    func configureViews() {
        self.indicator.activityIndicatorViewStyle = .whiteLarge
        self.indicator.startAnimating()
        self.backgroundColor = UIColor(colorLiteralRed: 255.0/255.0, green: 204.0/255.0, blue: 0.0/255.0, alpha: 1)
    }
    
}
