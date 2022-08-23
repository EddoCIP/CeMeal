//
//  IngredientPlanItem.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 18/08/22.
//

import SwiftUI

struct IngredientPlanItem: View {
    @Environment(\.locale) var locale
    
    var ingredient: Ingredient
    var isActive: Bool = false
    var action: () -> Void
    
    var body: some View {
        VStack {
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
            Spacer()
            Text("\(locale == Locale.init(identifier: "id") ?   ingredient.nama ?? ingredient.name ?? "Unknown" : ingredient.name ?? "Unknown")\n")
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .foregroundColor(Color.darkGreen)
                .font(.system(size: 15, weight: .semibold, design: .default))
        }
        .fixedSize(horizontal: false, vertical: true)
        .onTapGesture {
            action()
        }
    }
}

struct IngredientPlanItem_Previews: PreviewProvider {
    static var previews: some View {
        IngredientPlanItem(ingredient: Ingredient(context: PersistenceController.preview.container.viewContext)) {
            
        }
    }
}
