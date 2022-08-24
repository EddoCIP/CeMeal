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
                AsyncImageView(imageUrl: storage.storedIngredient?.imageUrl ?? "")
                .frame(width: 58, height: 58)
            }
            .background(Color.white)
            .frame(width: 90, height: 85)
            Spacer()
            VStack (alignment: .leading) {
                Text("\(locale == Locale.init(identifier: "id") ?   storage.storedIngredient?.nama ?? "Unknown" : storage.storedIngredient?.name ?? "Unknown")")
                    .font(.custom("SF Pro Display", size: 20, relativeTo: .title3))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.darkGreen)
                    .lineLimit(1)
                    .padding(.bottom, -5)
                Divider()
                if storage.isGood {
                    HStack {
                        Image(systemName: "face.smiling")
                        Text("\(storage.age) days old")
                            .fontWeight(.semibold)
                    }
                    .font(.custom("SF Compact Display", size: 13, relativeTo: .footnote))
                    .foregroundColor(Color.darkGreen)
                } else if storage.isSafe {
                    HStack {
                        Image(systemName: "staroflife.circle")
                        Text("\(storage.age) days old")
                            .fontWeight(.semibold)
                    }
                    .font(.custom("SF Compact Display", size: 13, relativeTo: .footnote))
                    .foregroundColor(Color.orange)
                } else {
                    HStack {
                        Image(systemName: "exclamationmark.circle")
                        Text("\(storage.age) days old")
                            .fontWeight(.semibold)
                    }
                    .font(.custom("SF Compact Display", size: 13, relativeTo: .footnote))
                    .foregroundColor(Color.darkRed)
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
