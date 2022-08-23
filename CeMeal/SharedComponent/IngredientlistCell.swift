//
//  IngredientlistCell.swift
//  CeMeal
//
//  Created by Rafik Lutfi on 22/08/22.
//

import SwiftUI

struct IngredientlistCell: View {
    @Environment(\.locale) var locale
    var storage: Storage
    
    var body: some View {
        
        HStack {
            HStack {
                AsyncImage(url: URL(string: storage.storedIngredient?.imageUrl ?? "")) { phase in
                    if let image = phase.image {
                        image.resizable()
                    } else if phase.error != nil {
                        Color.white
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 58, height: 58)
            }
            .background(Color.white)
            .frame(width: 90, height: 85)
            Spacer()
            VStack (alignment: .leading) {
                Text("\(locale == Locale.init(identifier: "id") ?   storage.storedIngredient?.nama ?? "Unknown" : storage.storedIngredient?.name ?? "Unknown")")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.darkGreen)
                    .lineLimit(1)
                Divider()
                if storage.isGood {
                    Label("\(storage.age) days old", systemImage: "face.smiling")
                        .foregroundColor(Color.green)
                        .font(.footnote)
                } else if storage.isSafe {
                    Label("\(storage.age) days old", systemImage: "staroflife.circle")
                        .foregroundColor(Color.lightOrange)
                        .font(.footnote)
                } else {
                    Label("\(storage.age) days old", systemImage: "exclamationmark.circle")
                        .foregroundColor(Color.darkRed)
                        .font(.footnote)
                }
            }
            Spacer()
            Rectangle()
                .foregroundColor(Color.white)
                .frame(width: 100, height: 85)
                .overlay(
                    Text("\(storage.quantity) Qty")
                        .foregroundColor(Color.darkGreen)
                        .font(.body)
                        .fontWeight(.semibold))
            
        }
        .background(Color.white)
        //        .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
    }
}

struct IngredientlistCell_Previews: PreviewProvider {
    static var previews: some View {
        IngredientlistCell(
            storage: Storage(context: PersistenceController.shared.container.viewContext)
        )
    }
}
