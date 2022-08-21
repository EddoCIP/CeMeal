//
//  IngredientPlanItem.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 18/08/22.
//

import SwiftUI

struct IngredientPlanItem: View {
    var ingredient: Ingredient
    var isActive: Bool = false
    var action: () -> Void
    
    var body: some View {
        VStack {
            Text("\(ingredient.name ?? "Unknown")")
                .foregroundColor(Color.darkGreen)
                .font(.system(size: 15))
                .bold()
            Spacer()
            AsyncImage(url: URL(string: ingredient.imageUrl ?? "")) { phase in
                if let image = phase.image {
                    image.resizable()
                } else if phase.error != nil {
                    Color.white
                } else {
                    ProgressView()
                }
            }
            .aspectRatio(contentMode: .fit)
            .padding(8)
            .frame(width: 70, height: 70)
            .background(Color.white)
            .overlay(
                Circle()
                    .stroke(isActive ? Color.green : Color.gray, lineWidth: isActive ? 10: 1)
            )
            .cornerRadius(90)
            
        }
        .onTapGesture {
            action()
        }
    }
    
    //    @ViewBuilder
    //    func showIngredientItem() ->
}

struct IngredientImage: View {
    var url: URL?
    
    var body: some View {
        AsyncImage(url: url) { phase in
            if let image = phase.image {
                image
            } else if phase.error != nil {
                //MARK: TO DO change to white image
                Image(systemName: "photo")
            } else {
                ProgressView()
            }
        }
    }
}

struct IngredientPlanItem_Previews: PreviewProvider {
    static var previews: some View {
        IngredientPlanItem(ingredient: Ingredient(context: PersistenceController.preview.container.viewContext)) {
            
        }
    }
}
