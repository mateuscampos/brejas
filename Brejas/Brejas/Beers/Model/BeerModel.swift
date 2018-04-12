//
//  BeerModel.swift
//  Brejas
//
//  Created by Mateus Campos on 30/06/17.
//  Copyright © 2017 Mateus Campos. All rights reserved.
//

import Foundation

class BeerModel: Codable {
    
    var beerId: Int?
    var beerName: String?
    var beerTagline: String?
    var beerDescription: String?
    var beerImageUrl: String?
    var beerAbv: Float?
    var beerIbu: Float?
    
    enum CodingKeys: String, CodingKey {
        case beerId = "id"
        case beerName = "name"
        case beerTagline = "tagline"
        case beerDescription = "description"
        case beerImageUrl = "image_url"
        case beerAbv = "abv"
        case beerIbu = "ibu"
    }
    
}
