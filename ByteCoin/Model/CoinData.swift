//
//  CoinData.swift
//  ByteCoin
//
//  Created by Daniel Lyubenov on 14.05.22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Codable {
    let assetIdQuote: String
    let rate: Double
    
    //JSON codable implementation
    enum CodingKeys: String, CodingKey {
        case assetIdQuote = "asset_id_quote"
        case rate = "rate"
    }
}
