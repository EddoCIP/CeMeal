//
//  GroceryList.swift
//  CeMeal
//
//  Created by Rafik Lutfi on 22/08/22.
//

import SwiftUI

struct GroceryList: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.lightGray).ignoresSafeArea()

            HStack {
                Rectangle()
                    .stroke(Color.black, lineWidth: 2)
                    .frame(width: 100, height: 75)
                Spacer()
                Text("Banana").font(.title).fontWeight(.medium).bold()
                Spacer()
                Capsule()
                    .foregroundColor(Color.lightGray)
                    .frame(width: 80, height: 35)
                    .overlay(Text("1")
                        .fontWeight(.bold))
                    .padding()
            }
            
            .background(Color.white)
            .clipShape(RoundedCorner(radius: 20, corners: [.bottomLeft, .topLeft]))
            
            .padding(.leading)
        }
    }
}

struct GroceryList_Previews: PreviewProvider {
    static var previews: some View {
        GroceryList()
    }
}
