//
//  ContentView.swift
//  Finance
//
//  Created by Mahutin Aleksei on 07/10/2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let income = Income()
    let cost = Cost()
    @State var selectedView = 1
    
    var body: some View {
        TabView {
            //main view
            ProfitView().environmentObject(income).environmentObject(cost)
                .tabItem {
                    Image(systemName: "circle")
                    Text("Доходы")
                }.tag(0)
            //graf view
            GraphView(showIncome: true).environmentObject(income).environmentObject(cost)
                .tabItem {
                    Image(systemName: "circle")
                    Text("График")
                }.tag(1)
            //cost view
            CostsView().environmentObject(income).environmentObject(cost)
                .tabItem({
                    Image(systemName: "circle")
                    Text("Расходы")
                })
            //view did load
        }.onAppear(perform: didLoad)
    }
    private func didLoad() {
        //add test data
        let items = [IncomeItem(id: 1, income: 7777, date: Date()),
                     IncomeItem(id: 2, income: 8888, date: Date(timeIntervalSince1970: 1570797356.902421)),
                     IncomeItem(id: 3, income: 3000, date: Date(timeIntervalSince1970: 1570710956.902421)),
                     IncomeItem(id: 4, income: 2500, date: Date(timeIntervalSince1970: 1570624556.902421)),
                     IncomeItem(id: 5, income: 4000, date: Date(timeIntervalSince1970: 1570538156.902421)),
                     IncomeItem(id: 6, income: 2000, date: Date(timeIntervalSince1970: 1570451756.902421)),
        ]
        let itemsCost = [CostItem(id: 1, catId: 1, name: "a", cost: 3033, date: Date()),
            CostItem(id: 1, catId: 1, name: "a", cost: 3033, date: Date(timeIntervalSince1970: 1570797356.902421)),
            CostItem(id: 1, catId: 1, name: "a", cost: 33, date: Date(timeIntervalSince1970: 1570710956.902421)),
            CostItem(id: 1, catId: 1, name: "a", cost: 7777, date: Date(timeIntervalSince1970: 1570624556.902421)),
            CostItem(id: 1, catId: 1, name: "a", cost: 200, date: Date(timeIntervalSince1970: 1570538156.902421)),
            CostItem(id: 1, catId: 1, name: "a", cost: 1700, date: Date(timeIntervalSince1970: 1570451756.902421)),
        ]
        
        
        for elem in items {
            PersistanceData.shared.addIncome(item: IncomeItemRealm(key: elem.id.hashValue, income: elem.income, date: elem.date))
        }
        PersistanceData.shared.addCategory(item: CostCategoryRealm(key: 666, name: "test"))
        for elem in itemsCost {
            PersistanceData.shared.addCost(item: CostItemRealm(key: elem.cost.hashValue, catKey: 666, cost: elem.cost, date: elem.date, name: elem.name))
        }
        income.updateDate()
        cost.updateDate()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
