//
//  PersistanceData.swift
//  Finance
//
//  Created by Alexei Mahutin on 10.10.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import Foundation
import RealmSwift

class IncomeItemRealm: Object {
    @objc dynamic var key: Int = 0
    @objc dynamic var income: Double = 0
    @objc dynamic var date: Date = Date()
    convenience init(key: Int, income: Double, date: Date) {
        self.init()
        self.key = key
        self.income = income
        self.date = date
    }
}

class CostCategoryRealm: Object {
    @objc dynamic var key: Int = 0
    @objc dynamic var name: String = ""
    convenience init(key: Int, name: String) {
        self.init()
        self.key = key
        self.name = name
    }
}

class CostItemRealm: Object {
    @objc dynamic var key: Int = 0
    @objc dynamic var catKey: Int = 0
    @objc dynamic var cost: Double = 0
    @objc dynamic var date: Date = Date()
    @objc dynamic var name: String = ""
    convenience init(key: Int, catKey: Int,
                     cost: Double, date: Date,
                     name: String) {
        self.init()
        self.key = key
        self.catKey = catKey
        self.cost = cost
        self.date = date
        self.name = name
    }

    
    
}

class PersistanceData {

    static let shared = PersistanceData()

    private let realm = try! Realm()

    //income
    
    func deleteIncome(withKey: Int) {
        let oldData = realm.objects(IncomeItemRealm.self).filter("key = \(withKey)")
        try! realm.write {
            if let data = oldData.first {
                realm.delete(data)
            }
        }
    }
    
    func addIncome(item: IncomeItemRealm) {
        try! realm.write {
            realm.add(item)
        }
    }
    
    func loadAllIncomes() -> [IncomeItemRealm] {
        let data = realm.objects(IncomeItemRealm.self)
        var result: [IncomeItemRealm] = []
        for item in data {
            result.append(item)
        }
        return result
    }
    
    //category
    
    func deleteCategory(withKey: Int) {
        //search category items
        let itemsData = realm.objects(CostItemRealm.self).filter("catKey = \(withKey)")
        //delete category
        let oldData = realm.objects(CostCategoryRealm.self).filter("key = \(withKey)")
        try! realm.write {
            //first delete items in category
            for item in itemsData {
                realm.delete(item)
            }
            //second delete category
            if let data = oldData.first {
                realm.delete(data)
            }
        }
    }
    
    func addCategory(item: CostCategoryRealm) {
        try! realm.write {
            realm.add(item)
        }
    }
    
    func loadAllCategory() -> [CostCategoryRealm] {
        let data = realm.objects(CostCategoryRealm.self)
        var result: [CostCategoryRealm] = []
        for item in data {
            result.append(item)
        }
        return result
    }
    
    func deleteCost(withKey: Int) {
        let oldData = realm.objects(CostItemRealm.self).filter("key = \(withKey)")
        try! realm.write {
            if let data = oldData.first {
                realm.delete(data)
            }
        }
    }
    
    func addCost(item: CostItemRealm) {
        try! realm.write {
            realm.add(item)
        }
    }
    
    func loadAllCost() -> [CostItemRealm] {
        let data = realm.objects(CostItemRealm.self)
        var result: [CostItemRealm] = []
        for item in data {
            result.append(item)
        }
        return result
    }
    
}
