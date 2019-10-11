//
//  CostsView.swift
//  Finance
//
//  Created by Alexei Mahutin on 09.10.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import SwiftUI

struct CostsView: View {
    @EnvironmentObject var cost: Cost
    
    //config
    let cellheight: CGFloat = Config.share.cellHeight
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var keyboard = KeyboardResponder()
    @State private var inputShow = false
    @State var listIsEdit = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack{
                    
                    //table view with all categories costs
                    List {
                        ForEach(cost.categories) { elem in
                            NavigationLink(destination: CategoryView(catId: elem.id, keyboard: self.keyboard).environmentObject(self.cost), label: {
                                Text(elem.name)
                            }).frame(height: self.cellheight)
                            }.onDelete(perform: deleteCat)
                            .deleteDisabled(!listIsEdit)
                    }
                    //padding for table
                    Spacer().frame(height: cellheight * 2)
                }
                
                //fill all view when user enters text
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
                
                //Create category view, show if one press to button
                VStack {
                    CreateCategory(inputShow: inputShow)
                        .environmentObject(cost)
                        .frame(height: cellheight * 2 + 100, alignment: .top)
                        .background(colorScheme == .dark ? Color.black : Color.white)
                }.offset(y: -keyboard.currentHeight + 100)
            }
            .navigationBarTitle(
                Text("Расходы")
                    .font(.custom("HelveticaNeue-Bold", size: 24))
            )
            .navigationBarItems(trailing: EditButton().simultaneousGesture(TapGesture().onEnded {
                self.listIsEdit.toggle()
            }))
        }.onAppear(perform: didAppear)
    }
    
    func didAppear() {
        listIsEdit = false
    }
    
    func deleteCat(at offsets: IndexSet) {
        offsets.forEach({ cost.removeCategory(item: cost.categories[$0]) })
    }
}

struct CostsView_Previews: PreviewProvider {
    static var cost = Cost()
    
    static var previews: some View {
        CostsView().environmentObject(cost)
    }
}
