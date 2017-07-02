//
//  BeerModel.swift
//  Brejas
//
//  Created by Mateus Campos on 30/06/17.
//  Copyright © 2017 Mateus Campos. All rights reserved.
//

import Foundation
import ObjectMapper


import ObjectMapper

class BeerModel : Mappable {
    
    var beerId: Int?
    var beerName: String?
    var beerTagline: String?
    var beerDescription: String?
    var beerImageUrl: String?
    var beerAbv: Float?
    var beerIbu: Float?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        beerId <- map["id"]
        beerName <- map["name"]
        beerTagline <- map["tagline"]
        beerDescription <- map["description"]
        beerImageUrl <- map["image_url"]
        beerAbv <- map["abv"]
        beerIbu <- map["ibu"]
    }
    
}
