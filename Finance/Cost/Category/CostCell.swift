//
//  CostCell.swift
//  Finance
//
//  Created by Alexei Mahutin on 10.10.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import SwiftUI

struct CostCell: View {
    var name: String
    var data: String
    var cost: String
    
    var body: some View {
        HStack{
            Text(name)
            Spacer()
            Text(data)
            Spacer()
            Text(cost)
        }.padding()
    }
}

struct CostCell_Previews: PreviewProvider {
    static var previews: some View {
        CostCell(name: "Жкх", data: "23.04.21", cost: "5000p")
    }
}
