//
//  CostsView.swift
//  Finance
//
//  Created by Alexei Mahutin on 09.10.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import SwiftUI

struct CostsView: View {
    let cellheight: CGFloat = 64
    @ObservedObject var keyboard = KeyboardResponder()
    @State private var inputShow = false
    @State private var inputtext = ""
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom){
                VStack{
                    Text("Расходы")
                    .font(.custom("HelveticaNeue-Bold", size: 24))
                    List(userCostCategorys) { elem in
                        NavigationLink(destination: CategoryView(), label: {
                            Text(elem.name)
                        })
                            .frame(height: self.cellheight)
                    }
                }
                VStack {
                    CreateCategory(inputShow: inputShow, inputtext: inputtext)
                        .frame(height: cellheight * 2 + 100, alignment: .top)
                        .background(Color.white)
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
