//
//  DataLoader.swift
//  Finance
//
//  Created by Alexei Mahutin on 10.10.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import SwiftUI


struct IncomeItem: Identifiable {
    let id: Int
    let income: Double
    let date: Date
    
    var textDate: String {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = String(calendar.component(.year, from: date))
        let textYear = year.suffix(from: year.index(year.startIndex, offsetBy: 2))
        return "\(day).\(month).\(textYear)"
    }
    
    var textIncome: String {
        return String(format:"%.2f",income) + "P"
    }
}

class Income: ObservableObject {
    
    @Published var items = [IncomeItem]()

    var incomeBalance: Double {
        if items.count > 0 {
            return items.reduce(0.0) { $0 + $1.income }
        }else{
            return 0
        }
        
    }
    
    func updateDate() {
        //load from realm
        let tempData = PersistanceData.shared.loadAllIncomes()
        let newData = tempData.map { IncomeItem(id: $0.key, income: $0.income, date: $0.date) }
        //update items
        for item in newData {
            if !items.contains(where: { (elem) -> Bool in
                return elem.id == item.id
            }) {
                items.append(item)
            }
        }
    }

    func add(income: Double) {
        let date = Date()
        let key = date.timeIntervalSince1970.hashValue
        //realm
        PersistanceData.shared.addIncome(item: IncomeItemRealm(key: key, income: income, date: date))
        updateDate()
    }

    func remove(item: IncomeItem) {
        items.removeAll { (elem) -> Bool in
            return elem.id == item.id
        }
        //realm
        PersistanceData.shared.deleteIncome(withKey: item.id)
    }
    
}


struct CostCategory: Identifiable {
    var id: Int
    var name: String
}

struct CostItem: Identifiable {
    var id: Int
    var catId: Int
    var name: String
    var cost: Double
    var date: Date
    
    var textDate: String {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = String(calendar.component(.year, from: date))
        let textYear = year.suffix(from: year.index(year.startIndex, offsetBy: 2))
        return "\(day).\(month).\(textYear)"
    }
    
    var textCost: String {
        return String(format:"%.2f",cost) + "P"
    }
}

class Cost: ObservableObject {
    
    @Published var categories = [CostCategory]()
    @Published var items = [CostItem]()
    
    
    var allCost: Double {
        if items.count > 0{
            return items.reduce(0.0) { $0 + $1.cost }
        }else{
            return 0
        }
        
    }
    
    func updateDate() {
        //load category from realm
        let catTempData = PersistanceData.shared.loadAllCategory()
        let newCatData = catTempData.map { CostCategory(id: $0.key, name: $0.name) }
        //update category
        for item in newCatData {
            if !categories.contains(where: { (elem) -> Bool in
                return elem.id == item.id
            }) {
                categories.append(item)
            }
        }
        //load costItems from realm
        let costTempData = PersistanceData.shared.loadAllCost()
        let newCostData = costTempData.map { CostItem(id: $0.key, catId: $0.catKey, name: $0.name, cost: $0.cost, date: $0.date) }
        //update costItems
        for item in newCostData {
            if !items.contains(where: { (elem) -> Bool in
                return elem.id == item.id
            }) {
                items.append(item)
            }
        }
    }
    
    func addCategory(income: String) {
        let key = income.hashValue
        //realm
        PersistanceData.shared.addCategory(item: CostCategoryRealm(key: key, name: income))
        updateDate()
    }
    
    func removeCategory(item: CostCategory) {
        categories.removeAll { (elem) -> Bool in
                return elem.id == item.id
        }
        //realm
        PersistanceData.shared.deleteCategory(withKey: item.id)
    }

    func add(cost: Double, catKey: Int, name: String) {
        let date = Date()
        let key = date.timeIntervalSince1970.hashValue
        //realm
        PersistanceData.shared.addCost(item: CostItemRealm(key: key, catKey: catKey, cost: cost, date: date, name: name))
        updateDate()
    }

    func remove(item: CostItem) {
        items.removeAll { (elem) -> Bool in
            return elem.id == item.id
        }
        //realm
        PersistanceData.shared.deleteCost(withKey: item.id)
    }
}
