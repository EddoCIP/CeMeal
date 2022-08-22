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
                Text("\(count) item(s)")
                    .foregroundColor(Color.white.opacity(0.6))
                    .font(.system(.caption, design: .rounded))
                    .bold()
            }
            Text(title + "\n")
                .font(.callout)
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.white)
                .padding(.bottom, 4)
                .lineLimit(2)
        }
        .background(Color.darkGreen)
        .cornerRadius(7)
        .frame(width: 100, height: 146)
        .shadow(radius: 5)
    }
}

struct IngredientCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientCategoryView(title: "Animal Products", count: 10)
    }
}
