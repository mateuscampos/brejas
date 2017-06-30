//
//  ViewCodingProtocol.swift
//  Brejas
//
//  Created by Mateus Campos on 30/06/17.
//  Copyright © 2017 Mateus Campos. All rights reserved.
//

import Foundation

protocol ViewCodingProtocol: class {
    func setupConstraints()
    func buildViewHierarchy()
    func configureViews()
    func setupViewConfiguration()
}

extension ViewCodingProtocol {
    func setupViewConfiguration() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    func configureViews() {
    }
}
