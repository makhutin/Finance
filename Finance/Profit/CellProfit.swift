//
//  CellProfit.swift
//  Finance
//
//  Created by Mahutin Aleksei on 07/10/2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import SwiftUI

struct CellProfit: View {
    
    var user: UserProfit
    
    var body: some View {
        HStack {
            Text(user.data)
            Spacer()
            Text(user.count)
            Spacer()
        }
        
    }
}

struct CellProfit_Previews: PreviewProvider {
    static var previews: some View {
        CellProfit(user: userData[0])
    }
}
