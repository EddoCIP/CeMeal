//
//  InputIngredient.swift
//  CeMeal
//
//  Created by Rafik Lutfi on 24/08/22.
//

import SwiftUI

struct InputIngredient: View {
    @State var ingredient = ""
    
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .overlay(Text(""))
                    .foregroundColor(Color.mint)
                    .frame(width: 75, height: 75)
                VStack (alignment: .leading) {
                    Text("Category")
                        .font(.title3)
                    Text("Animal product")
                        .font(.title3)
                }
                Spacer()
            }
            .padding()

            HStack {
                Text("My Ingredient")
                Spacer()
                Text("My Ingredient")
//                TextField(text: $ingredient)
            }
            .padding()
            .frame(width: 350, height: 40)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 7))
            .shadow(color: .black, radius: 1)
        }

    }
}

struct InputIngredient_Previews: PreviewProvider {
    static var previews: some View {
        InputIngredient()
    }
}
