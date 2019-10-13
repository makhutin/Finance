//
//  GraphView.swift
//  Finance
//
//  Created by Алексей Махутин on 13.10.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import SwiftUI

struct GraphView: View {
    @EnvironmentObject var income: Income
    @EnvironmentObject var cost: Cost
    @State var currentTypeGraph = TypeGraph.week
    @State var currentDays = 7
    @State var maxDate = Date()
    @State var minDate = Date()
    @State var maxNum = 0
    @State var stepNum: Int = 0
    @State var graphSizeH: CGFloat = 300
    @State var graphSizeV: CGFloat = 300
    @State var incomeForGraph = [IncomeItem]()
    @State var costForGraph = [CostItem]()
    @State var spacer: CGFloat = 40
    var catId = 0
    
    var minDateText: String {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: minDate)
        let month = calendar.component(.month, from: minDate)
        return "\(day).\(month)"
    }
    var maxDateText: String {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: maxDate)
        let month = calendar.component(.month, from: maxDate)
        return "\(day).\(month)"
    }
    
    var showIncome = true
    
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    self.currentTypeGraph = .week
                    self.updateGraph()
                }, label: {
                    Text("Неделя")
                })
                Button(action: {
                    self.currentTypeGraph = .month
                    self.updateGraph()
                }, label: {
                    Text("Месяц")
                })
                Button(action: {
                    self.currentTypeGraph = .quater
                    self.updateGraph()
                }, label: {
                    Text("Квартал")
                })
                Button(action: {
                    self.currentTypeGraph = .year
                    self.updateGraph()
                }, label: {
                    Text("Год")
                })
            }
            HStack(alignment: .bottom) {
                VStack {
                    Text("\(stepNum * 4)")
                    Spacer().frame(width: graphSizeH / 5, height: spacer)
                    Text("\(stepNum * 3)")
                    Spacer().frame(width: 1, height: spacer)
                    Text("\(stepNum * 2)")
                    Spacer().frame(width: 1, height: spacer)
                    Text("\(stepNum)")
                    Spacer().frame(width: 1, height: spacer)
                    Text("0")
                }
                Graphi(vLines: $currentDays, showIncome: showIncome, height: graphSizeV, width: graphSizeH, stepNum: $stepNum, itemsIncome: $incomeForGraph, itemsCost: $costForGraph)
            }
            HStack {
                Text(maxDateText)
                Spacer()
                Text(minDateText)
            }.padding()
            HStack {
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 5))
                    path.addLine(to: CGPoint(x: 50, y: 5))
                }
                .stroke(lineWidth: CGFloat(1))
                .foregroundColor(Color.red)
                .frame(width: 50, height: 10)
                Text("Расходы")
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 5))
                    path.addLine(to: CGPoint(x: 50, y: 5))
                }
                .stroke(lineWidth: CGFloat(1))
                .foregroundColor(Color.green)
                .frame(width: 50, height: 10)
                Text("Доходы")
            }
            Spacer()
            
        }.onAppear(perform: updateGraph)
        
    }

    
    func currentCost() {
        switch currentTypeGraph {
        case .week:
            currentDays = 7
        case .month:
            currentDays = 30
        case .quater:
            currentDays = 90
        case .year:
            currentDays = 360
        }
        minDate = Date(timeIntervalSince1970: Date().timeIntervalSince1970 - Double(60 * 60 * 24 * currentDays))
        let newCost = cost.items.filter { $0.date.timeIntervalSince1970 > minDate.timeIntervalSince1970 }
        let maxCost = newCost.max { $0.cost < $1.cost }
        if showIncome {
            let newIncome = income.items.filter { $0.date.timeIntervalSince1970 > minDate.timeIntervalSince1970 }
            let maxIncome = newIncome.max { $0.income < $1.income }
            let maxer = max(maxCost?.cost ?? 0,maxIncome?.income ?? 0)
            stepNum = Int(maxer) / 2000 * 2000 / 4
            maxNum = Int(stepNum * 5)
            incomeForGraph = []
            incomeForGraph = newIncome.sorted { $0.date.timeIntervalSince1970 < $1.date.timeIntervalSince1970 }
            costForGraph = []
            costForGraph = newCost.sorted { $0.date.timeIntervalSince1970 < $1.date.timeIntervalSince1970 }
        }else{
            stepNum = Int(maxCost?.cost ?? 0) / 2000 * 2000 / 4
            maxNum = Int(stepNum * 5)
            costForGraph = []
            let cost = newCost.sorted { $0.date.timeIntervalSince1970 < $1.date.timeIntervalSince1970 }
            costForGraph = cost.filter { $0.catId == catId }
        }
        
    }
    
    func updateGraph() {
        graphSizeH = UIScreen.main.bounds.width / 8 * 5
        spacer = graphSizeH / 7.8
        graphSizeV = graphSizeH
        income.updateDate()
        cost.updateDate()
        currentCost()
    }
}

struct GraphView_Previews: PreviewProvider {
    static let income = Income()
    static let cost = Cost()
    
    static var previews: some View {
        GraphView().environmentObject(income).environmentObject(cost)
    }
}
