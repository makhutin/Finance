//
//  CategoryView.swift
//  Finance
//
//  Created by Alexei Mahutin on 09.10.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import SwiftUI

struct CategoryView: View {
    private let buttonColor = Color(.sRGB, red: 0/255, green: 122/255, blue: 255/255, opacity: 1)
    
    var body: some View {
        VStack{
            Button(action: {
                
            }, label: {
                Text("График платежей").foregroundColor(.white)
            })
            .frame(width: UIScreen.main.bounds.width - 32, height: 50, alignment: .center)
            .background(buttonColor)
            .cornerRadius(25)
            List {
                Text("1")
            }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
