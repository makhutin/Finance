//
//  Graphi.swift
//  Finance
//
//  Created by Алексей Махутин on 12.10.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

enum TypeGraph {
    case quater,month,week,year
}


import SwiftUI

struct Graphi: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Binding var vLines: Int
    var showIncome: Bool = false
    let hLines = 6
    var height: CGFloat = 300
    var width: CGFloat = 300
    @Binding var stepNum: Int
    @Binding var itemsIncome: [IncomeItem]
    @Binding var itemsCost: [CostItem]
    
    
    var body: some View {
        ZStack{
            HStack {
                //Grid
                Path { path in
                    let gridStep: CGFloat = height / 5
                    let hGridStep = width / CGFloat(vLines - 1)
                    var y: CGFloat = 0
                    for _ in 0..<hLines {
                        path.move(to: CGPoint(x: 0, y: y))
                        path.addLine(to: CGPoint(x: hGridStep * CGFloat(vLines - 1) , y: y))
                        y += gridStep
                    }
                    var x: CGFloat = 0
                    for _ in 0..<vLines {
                        path.move(to: CGPoint(x: x, y: 0))
                        path.addLine(to: CGPoint(x: x, y: y - gridStep))
                        x += hGridStep
                    }
                }.stroke(lineWidth: 1)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    .opacity(0.3)
                
                
            }
            Path { path in
                let daysAgo = Double(60 * 60 * 24 * vLines)
                    let dateMinusCof = Date().timeIntervalSince1970 - daysAgo
                    let fullwidth = (width / CGFloat(vLines)) * CGFloat(vLines)
                    let dateCof =  fullwidth / CGFloat(daysAgo)
                    

                    let maxY = stepNum * 5
                    
                    //first elem
                    guard itemsCost.count > 0 else { return }
                    let firstItem = itemsCost.first!
                    let yF = height - height * CGFloat(firstItem.cost / Double(maxY))
                    let xF = fullwidth - CGFloat(firstItem.date.timeIntervalSince1970 - dateMinusCof) * dateCof
                    path.move(to: CGPoint(x: xF, y: yF))
                    //other elemments
                    for item in itemsCost[1...] {
                        let x = fullwidth - CGFloat(item.date.timeIntervalSince1970 - dateMinusCof) * dateCof
                        let y = height - height * CGFloat(item.cost / Double(maxY))
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                }.stroke(lineWidth: 1).foregroundColor(Color.red)
            
            
            //Grapg Income
            if showIncome {
                Path { path in
                    
                    let daysAgo = Double(60 * 60 * 24 * vLines)
                    let dateMinusCof = Date().timeIntervalSince1970 - daysAgo
                    let fullwidth = (width / CGFloat(vLines)) * CGFloat(vLines)
                    let dateCof =  fullwidth / CGFloat(daysAgo)
                    
                    let maxY = stepNum * 5
                    
                    //first elem
                    guard itemsIncome.count > 0 else { return }
                    let firstItem = itemsIncome.first!
                    let yF = height - height * CGFloat(firstItem.income / Double(maxY))
                    let xF = fullwidth - CGFloat(firstItem.date.timeIntervalSince1970 - dateMinusCof) * dateCof
                        path.move(to: CGPoint(x: xF, y: yF))
                    
                    //other elemments
                    for item in itemsIncome[1...] {
                        let x = fullwidth - CGFloat(item.date.timeIntervalSince1970 - dateMinusCof) * dateCof
                        let y = height - height * CGFloat(item.income / Double(maxY))
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                }.stroke(lineWidth: 1).foregroundColor(Color.green)
            }
        }.frame(width: width, height: height)
    }
    
}

struct Graphi_Previews: PreviewProvider {
    
    @State static var testncome = [IncomeItem(id: 1, income: 7777, date: Date()),
                    IncomeItem(id: 2, income: 8888, date: Date(timeIntervalSince1970: 1570797356.902421)),
                    IncomeItem(id: 3, income: 3000, date: Date(timeIntervalSince1970: 1570710956.902421)),
                    IncomeItem(id: 4, income: 2500, date: Date(timeIntervalSince1970: 1570624556.902421)),
                    IncomeItem(id: 5, income: 4000, date: Date(timeIntervalSince1970: 1570538156.902421)),
                    IncomeItem(id: 6, income: 2000, date: Date(timeIntervalSince1970: 1570451756.902421)),
]
    @State static var testCost = [CostItem(id: 1, catId: 1, name: "a", cost: 3033, date: Date()),
        CostItem(id: 1, catId: 1, name: "a", cost: 3033, date: Date(timeIntervalSince1970: 1570797356.902421)),
        CostItem(id: 1, catId: 1, name: "a", cost: 33, date: Date(timeIntervalSince1970: 1570710956.902421)),
        CostItem(id: 1, catId: 1, name: "a", cost: 7777, date: Date(timeIntervalSince1970: 1570624556.902421)),
        CostItem(id: 1, catId: 1, name: "a", cost: 200, date: Date(timeIntervalSince1970: 1570538156.902421)),
        CostItem(id: 1, catId: 1, name: "a", cost: 1700, date: Date(timeIntervalSince1970: 1570451756.902421)),
    ]
    @State static var inter = 7
    
    static var previews: some View {
        Graphi(vLines: $inter, stepNum: $inter, itemsIncome: $testncome, itemsCost: $testCost)
    }
}

