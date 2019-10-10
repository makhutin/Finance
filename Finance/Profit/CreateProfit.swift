//
//  CreateProfit.swift
//  Finance
//
//  Created by Alexei Mahutin on 08.10.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import SwiftUI

struct CreateProfit: View {
    //config
    private let buttonColor = Config.share.buttonColor
    
    @State var inputShow: Bool
    @State private(set) var inputtext = ""
    
    
    var body: some View {
        VStack {
            //textfield
            HStack{
                TextField("Сумма", text: $inputtext)
                    .keyboardType(.numberPad)
                    .scaledToFit()
                Text(inputtext.isEmpty ? "" : "P")
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
                        self.inputtext = ""
                        self.inputShow.toggle()
                        self.endEditing(true)
                    }
                }
            }, label: {
                VStack{
                    Text("Добавить доход").foregroundColor(.white)
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

struct CreateProfit_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfit(inputShow: true)
    }
}
