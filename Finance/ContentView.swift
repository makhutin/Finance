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
            Text("Second View")
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
        income.updateDate()
        cost.updateDate()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
