//
//  TrashedIngredientSummary.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 23/08/22.
//

import SwiftUI
import CoreData

struct TrashedIngredientSummary: View {
    @FetchRequest(sortDescriptors: []) var trashList : FetchedResults <TrashedIngredient>
    
    var totalCount: Int {
        trashList.map { Int($0.quantity) }.reduce(0, +)
    }
    
    var countPerIngredient: [Dictionary<String, Int>.Element] {
        var result = [String: Int]()
        let dictionary = Dictionary(grouping: trashList) { $0.trashToIngredient?.name ?? "" }
        
        for key in dictionary.keys {
            let filteredRecord = trashList.filter { $0.trashToIngredient?.name ?? "" == key }
            result[key] = filteredRecord.map {Int($0.quantity)}.reduce(0, +)
        }
        
        return result.sorted { $0.value > $1.value}
    }
    
    var body: some View {
        HStack {
            Image(systemName: "trash.fill")
                .font(.custom("SF Compact Display", size: 28, relativeTo: .title))
                .foregroundColor(Color.darkRed)
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("Trashed")
                        .font(.custom("SF Pro Display", size: 20, relativeTo: .title3))
                        .fontWeight(.medium)
                    Spacer()
                    Text("\(totalCount) items")
                        .font(.custom("SF Compact Display", size: 13, relativeTo: .footnote))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.darkRed)
                }
                .padding(.bottom, 5)
                Divider()
                if !countPerIngredient.isEmpty {
                    HStack {
                        Text("Never buy \(countPerIngredient[0].key.lowercased()) again, you always dump them..")
                            .newYorkFont(size: 12)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                Spacer()
            }
        }
    }
}

//struct TrashedIngredientSummary_Previews: PreviewProvider {
//    static var previews: some View {
//        TrashedIngredientSummary()
//    }
//}
