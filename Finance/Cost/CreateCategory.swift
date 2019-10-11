//
//  CreateCategory.swift
//  Finance
//
//  Created by Alexei Mahutin on 09.10.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import SwiftUI

struct CreateCategory: View {
    @EnvironmentObject var cost: Cost
    //config
    let buttonColor = Config.share.buttonColor
    
    @State var inputShow: Bool
    @State private(set) var inputtext = ""
    
    
    var body: some View {
        VStack {
            
            //text field
            HStack{
                TextField("Наименование", text: $inputtext)
                    .scaledToFit()
                Spacer()
            }
            .padding()
            .opacity(inputShow ? 1 : 0).animation(.easeInOut)
            
            //button
            Button(action: {
                //button action
                if !self.inputShow {
                    withAnimation {
                        self.inputShow.toggle()
                    }
                }else{
                    withAnimation {
                        self.cost.addCategory(income: self.inputtext)
                        self.inputtext = ""
                        self.inputShow.toggle()
                        self.endEditing(true)
                    }
                }
            }, label: {
                VStack{
                    Text("Добавить категорию расходов").foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50, alignment: .center)
                    .background((inputtext.isEmpty && inputShow) ? buttonColor.opacity(0.7) : buttonColor )
                    .cornerRadius(25)
                }
                
                })
                .disabled(inputtext.isEmpty && inputShow)
                .padding()
            .offset(y: -20)
            }
        }
}

struct CreateCategory_Previews: PreviewProvider {
    static var cost = Cost()
    
    static var previews: some View {
        CreateCategory(inputShow: true).environmentObject(cost)
    }
}
