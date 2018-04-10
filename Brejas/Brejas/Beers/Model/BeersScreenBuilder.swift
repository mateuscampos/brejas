//
//  BeersScreenBuilder.swift
//  Brejas
//
//  Created by Mateus Campos on 02/07/17.
//  Copyright © 2017 Mateus Campos. All rights reserved.
//

import Foundation
import UIKit

class BeersScreenBuilder {
    
    static func beersListController() -> UINavigationController {
        
        let navController: UINavigationController = UINavigationController()
        let factory = BeerDataSourceFactory { selectedItem in
            navController.pushViewController(self.beerDetailController(beer: selectedItem), animated: true)
        }
        let beerController = BeersListController(beerFactory: factory)
        navController.viewControllers = [beerController]
        return navController
        
    }
    
    static func beerDetailController(beer: BeerModel? = nil) -> BeerDetailController {
        
        if let object = beer {
            return BeerDetailController(beer: object)
        } else {
            return BeerDetailController()
        }
        
    }
    
}
