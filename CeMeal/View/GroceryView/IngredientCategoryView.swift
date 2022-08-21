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
        ZStack {
            RoundedCorner(radius: 15, corners: .allCorners)
                .fill(Color.white)
                .shadow(radius: 5)
            VStack {
                Image(systemName: "house.fill")
                Spacer()
                Text("\(count) item(s)")
                    .font(.caption)
            }
            .padding()
        }
        .frame(width: 100, height: 100)
    }
}

struct IngredientCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientCategoryView(title: "Ayam", count: 10)
    }
}
