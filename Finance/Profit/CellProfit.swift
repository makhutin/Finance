//
//  CellProfit.swift
//  Finance
//
//  Created by Mahutin Aleksei on 07/10/2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import SwiftUI

struct CellProfit: View {
    
    var user: IncomeItem
    
    var body: some View {
        HStack {
            Text(user.textDate)
            Spacer()
            Text(user.textIncome)
            Spacer()
        }
    }
    
}

struct CellProfit_Previews: PreviewProvider {
    static let income = Income()
    
    static var previews: some View {
        CellProfit(user: income.items[0])
    }
}
