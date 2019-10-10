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

struct UserCostCategory: Hashable, Codable, Identifiable{
    var id: Int
    var name: String
    var items: [CostItem]
}

struct CostItem: Hashable, Codable {
    var name: String
    var cost: String
    var date: String
}



var userData = [ UserProfit(id: 0, data: "10.10.21", count: "19 000", countDouble: 19000),
                 UserProfit(id: 1, data: "10.10.20", count: "19 000", countDouble: 17000),
                 UserProfit(id: 2, data: "10.10.19", count: "19 000", countDouble: 15000),
                 UserProfit(id: 3, data: "10.13.21", count: "19 000", countDouble: 14000),
                 UserProfit(id: 4, data: "10.13.21", count: "19 000", countDouble: 12321.345)
]

var userCostCategorys = [ UserCostCategory(id: 0, name: "Дом",
                                          items: [
                                            CostItem(name: "Жкх", cost: "7000p", date: "21.23.12"),
                                            CostItem(name: "Плов", cost: "7000p", date: "21.23.12"),
                                            CostItem(name: "Еда", cost: "7000p", date: "21.23.12")
]),
                          UserCostCategory(id: 1, name: "Продукты", items: [] ),
                         UserCostCategory(id: 2, name: "Досуг", items: [] ),
                         UserCostCategory(id: 3, name: "Постоянные траты", items: [] ),
                         UserCostCategory(id: 4, name: "Путешествия", items: [] )
]
