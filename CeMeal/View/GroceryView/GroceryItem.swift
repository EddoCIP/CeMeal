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
        ZStack {
            HStack {
                HStack {
                    Circle()
                        .foregroundColor(Color.lightGray)
                        .overlay {
                            Circle()
                                .foregroundColor(Color.lightGreen)
                        }
                    Spacer()
                    AsyncImage(url: URL(string: grocery.groceryToIngredient?.imageUrl ?? "")) { phase in
                        if let image = phase.image {
                            image.resizable()
                        } else if phase.error != nil {
                            Color.white
                        } else {
                            ProgressView()
                        }
                    }
                        .frame(width: 52, height: 52)
                }
                .frame(width: 96, height: 60)
                Text("\(grocery.groceryToIngredient?.name ?? "unknown")").font(.title2)
                Spacer()
                Capsule()
                    .foregroundColor(Color.lightGray)
                    .frame(width: 80, height: 35)
                    .overlay(Text("\(grocery.quantity)")
                        .fontWeight(.bold))
                    .padding()
            }
            .background(Color.white)
            .clipShape(RoundedCorner(radius: 20, corners: [.bottomLeft, .topLeft]))
        }
    }
}

struct GroceryItem_Previews: PreviewProvider {
    static var previews: some View {
        GroceryItem(grocery: Grocery(context: PersistenceController.preview.container.viewContext))
    }
}
