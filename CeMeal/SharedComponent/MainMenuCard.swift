//
//  MainMenuCard.swift
//  CeMeal
//
//  Created by Rafik Lutfi on 23/08/22.
//

import SwiftUI

struct MainMenuCard: View {
    @Environment(\.locale) var locale
    
    let notSafeRemark = "Throw them away now! You might get food poisoning."
    let safeRemark = "Consume right away! It’s getting bad day by day."
    
    var storage: Storage
    
    var body: some View {
        VStack(alignment: .center) {
            Text("\(locale == Locale.init(identifier: "id") ?   storage.storedIngredient?.nama ?? "Unknown" : storage.storedIngredient?.name ?? "Unknown")")
                .lineLimit(1)
            
            AsyncImageView(imageUrl: storage.storedIngredient?.imageUrl ?? "")
            .frame(width: 80, height: 80, alignment: .center)
            .background(Color.white)
            Text("\(storage.isDanger ? notSafeRemark : safeRemark)")
                .newYorkFont(size: 14)
                .foregroundColor(storage.isDanger ? Color.darkRed : Color.orange)
                .multilineTextAlignment(.leading)
                .frame(width: 98)
            Spacer()
            
            HStack {
                Image(systemName: storage.isDanger ? "exclamationmark.circle" : "staroflife.circle")
                Text("\(storage.age) days old")
                    .fontWeight(.semibold)
            }
            .font(.custom("SF Compact Display", size: 13, relativeTo: .footnote))
            .foregroundColor(storage.isDanger ? Color.darkRed : Color.orange)
            .lineLimit(1)
        }
        .padding(2)
        .frame(width: 120, height: 229)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 7))
        .shadow(color: .black, radius: 2)
    }
}

struct MainMenuCard_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuCard(storage: Storage(context: PersistenceController.shared.container.viewContext))
    }
}
