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
                getCategoryIcon(category: title)
                    .resizable()
                VStack(alignment: .trailing) {
                    HStack {
                        Spacer()
                        Text("\(count)")
                            .foregroundColor(Color.white.opacity(0.6))
                            .font(.caption)
                            .fontWeight(.medium)
                            .bold()
                            .frame(width: 27, height: 27)
                            .background(Color.darkerGreen)
                            .cornerRadius(90)
                    }
                    Spacer()
                }.padding(5)
            }
            Text(title + (title.count > 13 ? "" : "\n"))
                .compactFont(size: 16)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.darkerGreen)
                .padding(.bottom, 4)
                .lineLimit(2)
        }
        .background(Color.white)
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
