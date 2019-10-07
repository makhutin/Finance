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
    
    var body: some View {
        VStack {
            HStack {
                Text("Текущий баланс:")
                Spacer()
                Text("баланс")
                }
            .padding(16)
            .frame(height: cellheight, alignment: .center)
            Text("Доходы").frame(width: UIScreen.main.bounds.width, height: cellheight, alignment: .center)
            List(content: {
                Text("1")
            })
            Spacer()
            VStack() {
                Button(action: {
                    
                }, label: {
                    Text("Добавить доход").foregroundColor(.white)
                    })
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50, alignment: .center)
                    .background(Color(.sRGB, red: 0/255, green: 122/255, blue: 255/255, opacity: 1))
                    .cornerRadius(25)
                    
            }
            .frame(height: cellheight * 2)
        }
        
    }
}

struct Profit_Previews: PreviewProvider {
    static var previews: some View {
        ProfitView()
    }
}
