//
//  Profit.swift
//  Finance
//
//  Created by Mahutin Aleksei on 07/10/2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import SwiftUI

struct ProfitView: View {
    @EnvironmentObject var income: Income
    @EnvironmentObject var cost: Cost
    
    //config
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @ObservedObject var keyboard = KeyboardResponder()
    @State private var inputShow = false
    
    let cellheight: CGFloat = Config.share.cellHeight
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                //current balance
                HStack {
                    Text("Текущий баланс:")
                        .font(.system(size: 16))
                    Spacer()
                    //Balance
                    Text(getBalance())
                        .font(.custom("HelveticaNeue-Bold", size: 24))
                    }
                .padding(16)
                .frame(height: cellheight, alignment: .center)
                
                Text("Доходы")
                    .frame(height: cellheight, alignment: .center)
                    .font(.custom("HelveticaNeue-Bold", size: 28))
                //table with data all incomme
                List {
                    ForEach(income.items) { user in
                    CellProfit(user: user)
                        .frame(height: self.cellheight, alignment: .center)
                    }
                    .onDelete(perform: deleteItems)
                }
                //padding for table
                Spacer().frame(height: cellheight * 2)
            }
            //fill view when user enters text
            if keyboard.currentHeight > 0 {
                withAnimation(.easeInOut) {
                    VStack {
                        Spacer()
                        HStack{
                            Spacer()
                        }
                    }.background( colorScheme == .dark ? Color.white : Color.black).opacity(0.4)
                }
            }
            //create profit view, show when press add income
            VStack {
                CreateProfit(inputShow: inputShow)
                    .frame(height: cellheight * 2 + 100, alignment: .top)
                    .background(colorScheme == .dark ? Color.black : Color.white)
            }.offset(y: -keyboard.currentHeight + 100)
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        offsets.forEach({ income.remove(item: income.items[$0]) })
    }
    
    func getBalance() -> String{
        return String(format:"%.2f",income.incomeBalance - cost.allCost) + "P"
    }
    
}

struct Profit_Previews: PreviewProvider {
    static let income = Income()
    static let cost = Cost()
    static var previews: some View {
        ProfitView().environmentObject(income).environmentObject(cost)
    }
}
