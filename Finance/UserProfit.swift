//
//  UserProfit.swift
//  Finance
//
//  Created by Mahutin Aleksei on 07/10/2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import SwiftUI

struct UserProfit: Hashable, Codable, Identifiable{
    var id: Int
    var data: String
    var count: String
    var countDouble: Double
}

var userData = [ UserProfit(id: 0, data: "10.10.21", count: "19 000", countDouble: 19000),
                 UserProfit(id: 1, data: "10.10.20", count: "19 000", countDouble: 17000),
                 UserProfit(id: 2, data: "10.10.19", count: "19 000", countDouble: 15000),
                 UserProfit(id: 3, data: "10.13.21", count: "19 000", countDouble: 14000),
                 UserProfit(id: 4, data: "10.13.21", count: "19 000", countDouble: 12321.345)
]

