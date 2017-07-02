//
//  LoadingView+UIViewController.swift
//  Brejas
//
//  Created by Mateus Campos on 02/07/17.
//  Copyright © 2017 Mateus Campos. All rights reserved.
//

import Foundation


extension UIViewController: Loadable {
    
    var activityIndicatorView: LoadingView {
        return LoadingView.viewInstance
    }
    
    func showLoading() {
        self.view.addSubview(activityIndicatorView)
        
        self.activityIndicatorView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    func hideLoading() {
        activityIndicatorView.removeFromSuperview()
    }
    
}
