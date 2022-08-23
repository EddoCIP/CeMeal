//
//  ConsumedIngredientSummary.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 23/08/22.
//

import SwiftUI

struct ConsumedIngredientSummary: View {
    @FetchRequest(sortDescriptors: []) var consumeList : FetchedResults <ConsumedIngredient>
    
    var totalCount: Int {
        consumeList.map { Int($0.quantity) }.reduce(0, +)
    }
    
    var body: some View {
        HStack {
            Image(systemName: "fork.knife")
                .font(.custom("SF Compact Display", size: 28, relativeTo: .title))
                .foregroundColor(Color.lightGreen)
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("Consumed")
                        .font(.custom("SF Pro Display", size: 20, relativeTo: .title3))
                        .fontWeight(.medium)
                    Spacer()
                    Text("\(totalCount) items")
                        .font(.custom("SF Compact Display", size: 13, relativeTo: .footnote))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.lightGreen)
                }
                .padding(.bottom, 5)
                Divider()
                HStack {
                    Text("You seem to like eggs, stick to it!")
                        .newYorkFont(size: 12)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

struct ConsumedIngredientSummary_Previews: PreviewProvider {
    static var previews: some View {
        ConsumedIngredientSummary()
    }
}
