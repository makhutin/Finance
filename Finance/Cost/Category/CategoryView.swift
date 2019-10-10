//
//  CategoryView.swift
//  Finance
//
//  Created by Alexei Mahutin on 09.10.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import SwiftUI

struct CategoryView: View {
    //config
    let buttonColor = Config.share.buttonColor
    let cellheight = Config.share.cellHeight
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var keyboard: KeyboardResponder
    @State private(set) var inputName = ""
    @State private(set) var inputCount = ""
    @State private var showCreate = false
    
    var category: UserCostCategory
    
    var body: some View {
        // zstack first for create item count
        ZStack (alignment: .bottom) {
            ZStack(alignment: .bottom) {
                    VStack(alignment: .center, spacing: 10){
                        
                        // top button with graf
                        Button(action: {
                        }, label: {
                            Text("График платежей").foregroundColor(.white)
                        })
                            .frame(width: UIScreen.main.bounds.width - 32, height: 50, alignment: .center)
                            .background(buttonColor)
                            .cornerRadius(25)
                            .offset(y: 7)
                        Spacer()
                            .frame(height: 15)
                        
                        //table with all items costs in current category
                        List {
                            CostCell(name: "На что", data: "Когда", cost: "Сколько").foregroundColor(Color.gray)
                            ForEach(category.items, id: \.self) { elem in
                                CostCell(name: elem.name, data: elem.date, cost: elem.cost)
                            }
                        }
                        
                        //bottom button add new costs
                        Button(action: {
                                self.showCreate.toggle()
                            }, label: {
                                Text("\u{002B}")
                                    .foregroundColor(.white)
                                    .font(.system(size: 40))
                            })
                                .frame(width: 50, height: 50, alignment: .center)
                            .offset(y: -2)
                            .background(buttonColor)
                            .cornerRadius(25)
                            Text("Добавить расход")
                                .font(.custom("HelveticaNeue-Bold", size: 24))
                            .offset(y: -5)
                        }
                            .frame(width: UIScreen.main.bounds.width)
                            .background(colorScheme == .dark ? Color.black : Color.white)
                        
            }
            //fill all views when user enters text
            if keyboard.currentHeight > 0 {
                withAnimation(.easeInOut) {
                    VStack {
                        Spacer()
                        HStack{
                            Spacer()
                        }
                    }.background( colorScheme == .dark ? Color.white : Color.black).opacity(0.4)
                }
            }
            
            //show create item count view
            if showCreate {
                VStack {
                    //TextFields
                     VStack{
                         HStack{
                             TextField("Сумма", text: $inputCount)
                                 .keyboardType(.numberPad)
                                 .scaledToFit()
                                 .frame(minWidth: 55,alignment: .leading)
                             Text(inputCount.isEmpty ? "" : "P")
                             Spacer()
                         }
                         Spacer().frame(height: 10)
                         TextField("Наименнование", text: $inputName)
                         }
                     .padding()
                    
                    //Button
                    Button(action: {
                         withAnimation {
                             self.inputCount = ""
                             self.inputName = ""
                             self.showCreate = false
                             self.endEditing(true)
                        }
                    }, label: {
                        VStack{
                            Text("Добавить доход").foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width - 32, height: 50, alignment: .center)
                             .background((inputCount.isEmpty || inputName.isEmpty) ? buttonColor.opacity(0.7) : buttonColor )
                            .cornerRadius(25)
                        }
                        
                        })
                        .disabled(inputCount.isEmpty || inputName.isEmpty)
                        .padding()
                    .offset(y: -20)
                }
                    .frame(height: cellheight * 3 + 50, alignment: .top)
                    .background(colorScheme == .dark ? Color.black : Color.white)
                    .offset(y: -keyboard.currentHeight + 100)
            }
        }.navigationBarTitle(Text(""),displayMode: .inline)
        
        
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(keyboard: KeyboardResponder(), category: UserCostCategory(id: 0, name: "Дом",
                                                                               items: [
                                                                                CostItem(name: "Жкх", cost: "7000p", date: "21.23.12"),
                                                                                CostItem(name: "Плов", cost: "7000p", date: "21.23.12"),
                                                                                CostItem(name: "Еда", cost: "7000p", date: "21.23.12"),]))
    }
}
