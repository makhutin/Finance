//
//  CostsView.swift
//  Finance
//
//  Created by Alexei Mahutin on 09.10.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import SwiftUI

struct CostsView: View {
    //config
    let cellheight: CGFloat = Config.share.cellHeight
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var keyboard = KeyboardResponder()
    @State private var inputShow = false
    @State private var inputtext = ""
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom){
                VStack{
                    Text("Расходы")
                    .font(.custom("HelveticaNeue-Bold", size: 24))
                    
                    //table view with all categories costs
                    List(userCostCategorys) { elem in
                        NavigationLink(destination: CategoryView(keyboard: self.keyboard, category: elem)
                            , label: {
                            Text(elem.name)
                        })
                            .frame(height: self.cellheight)
                    }
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
                    CreateCategory(inputShow: inputShow, inputtext: inputtext)
                        .frame(height: cellheight * 2 + 100, alignment: .top)
                        .background(colorScheme == .dark ? Color.black : Color.white)
                }.offset(y: -keyboard.currentHeight + 100)
            }
            .navigationBarTitle("Back")
            .navigationBarHidden(true)
        }
    }
}

struct CostsView_Previews: PreviewProvider {
    static var previews: some View {
        CostsView()
    }
}
