//
//  Profit.swift
//  Finance
//
//  Created by Mahutin Aleksei on 07/10/2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import SwiftUI

struct ProfitView: View {
    let cellheight: CGFloat = 64
    @ObservedObject var keyboard = KeyboardResponder()
    @State private var inputShow = false
    @State private var inputtext = ""
    var count: Double {
        return userData.reduce(into: 0.0) { (res, elem) in
            res += elem.countDouble
        }
    }
    var textCount: String {
        get {
            let value = String(format:"%.2f",count) + "P"
            return value
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                HStack {
                    Text("Текущий баланс:")
                        .font(.system(size: 16))
                    Spacer()
                    Text(textCount)
                        .font(.custom("HelveticaNeue-Bold", size: 24))
                    }
                .padding(16)
                .frame(height: cellheight, alignment: .center)
                Text("Доходы")
                    .frame(height: cellheight, alignment: .center)
                    .font(.custom("HelveticaNeue-Bold", size: 28))
                List(userData) { user in
                    CellProfit(user: user)
                        .frame(height: self.cellheight, alignment: .center)
                }
            }
            VStack {
                CreateProfit(inputShow: inputShow, inputtext: inputtext)
                    .frame(height: cellheight * 2 + 100, alignment: .top)
                    .background(Color.white)
            }.offset(y: -keyboard.currentHeight + 100)
        }
    }
}

struct Profit_Previews: PreviewProvider {
    static var previews: some View {
        ProfitView()
    }
}
