//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Daniel Lyubenov on 14.05.22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let currencyName: String
    let lastPrice: Double
    
    var rateAsString: String {
        return String(format: "%.2f", self.lastPrice)
    }
}
