//
//  IngredientCategoryView.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 21/08/22.
//

import SwiftUI

struct IngredientCategoryView: View {
    var title: String
    var count: Int
    
    var body: some View {
        VStack {
                ZStack {
                    Color.gray
                        .ignoresSafeArea()
                    Image("shoppingCart")
                        .resizable()
                    Text(title)
                        .font(.body)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.white)
                }
                Text("\(count) item(s)")
                    .foregroundColor(Color.darkGreen.opacity(0.6))
                    .font(.caption)
                    .bold()
                    .padding(.bottom, 4)
            }
            .background(Color.white)
            .cornerRadius(7)
            .frame(width: 100, height: 100)
            .shadow(radius: 5)
    }
}

struct IngredientCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientCategoryView(title: "Ayam", count: 10)
    }
}
