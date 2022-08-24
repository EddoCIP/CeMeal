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
    
    var countPerIngredient: [Dictionary<String, Int>.Element] {
        var result = [String: Int]()
        let dictionary = Dictionary(grouping: consumeList) { $0.consumeToIngredient?.name ?? "" }
        
        for key in dictionary.keys {
            let filteredRecord = consumeList.filter { $0.consumeToIngredient?.name ?? "" == key }
            result[key] = filteredRecord.map {Int($0.quantity)}.reduce(0, +)
        }
        
        return result.sorted { $0.value > $1.value}
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
                if !countPerIngredient.isEmpty {
                    HStack {
                        Text("You seem to like \(countPerIngredient[0].key.lowercased()), stick to it!")
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                        Spacer()
                    }
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
