//
//  GroceryItem.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 18/08/22.
//

import SwiftUI

struct GroceryItem: View {
    var grocery: Grocery
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedCorner(radius: 8, corners: [.topLeft, .bottomLeft])
                .fill(Color.listColor)
            HStack {
                Image(systemName: "house")
                Text("\(grocery.groceryToIngredient?.name ?? "Unknown")")
                    .font(.system(.body, design: .rounded))
                    .bold()
                Spacer()
                Divider()
                Stepper("") {
                    
                } onDecrement: {
                    
                }
                .frame(width: 150)
                
            }.padding()
        }
    }
}

struct GroceryItem_Previews: PreviewProvider {
    static var previews: some View {
        GroceryItem(grocery: Grocery(context: PersistenceController.preview.container.viewContext))
    }
}
