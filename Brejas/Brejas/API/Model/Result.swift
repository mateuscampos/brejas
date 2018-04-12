//
//  Result.swift
//  Brejas
//
//  Created by mateus.campos on 12/04/2018.
//  Copyright © 2018 Mateus Campos. All rights reserved.
//

import Foundation

public enum Result<T> {
    case success(T)
    case error(Error)
}
