//
//  StorageIngredientItemView.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 23/08/22.
//

import SwiftUI

struct StorageIngredientItem: View {
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
            VStack(alignment: .leading) {
                Text("\(locale == Locale.init(identifier: "id") ?   storage.storedIngredient?.nama ?? storage.storedIngredient?.name ?? "Unknown" : storage.storedIngredient?.name ?? "Unknown")")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.darkGreen)
                Divider()
                if storage.isGood {
                    Label("\(storage.age) days old", systemImage: "face.smiling")
                        .foregroundColor(Color.green)
                } else if storage.isSafe {
                    Label("\(storage.age) days old", systemImage: "staroflife.circle")
                        .foregroundColor(Color.lightOrange)
                } else {
                    Label("\(storage.age) days old", systemImage: "exclamationmark.circle")
                        .foregroundColor(Color.darkRed)
                }
            }
            VStack {
                Text("\(storage.quantity) Qty")
                    .foregroundColor(Color.darkGreen)
                    .font(.body)
                    .fontWeight(.semibold)
            }
        }
    }
}

struct StorageIngredientItem_Previews: PreviewProvider {
    static var previews: some View {
        StorageIngredientItem(
            storage: Storage(context: PersistenceController.shared.container.viewContext)
        )
    }
}