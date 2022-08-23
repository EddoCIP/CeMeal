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
                HStack {
                    Text("Never buy cucumbers again, you always dump them..")
                        .newYorkFont(size: 12)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer()
            }
        }
        .onAppear {
            summary()
        }
    }
    
    func summary() {
        let moc = PersistenceController.shared.container.viewContext
        
        let keypathExp1 = NSExpression(forKeyPath: "trashToIngredient.name")
        let expression = NSExpression(forFunction: "sum:", arguments: [keypathExp1])
        let sumDesc = NSExpressionDescription()
        sumDesc.expression = expression
        sumDesc.name = "sum"
        sumDesc.expressionResultType = .integer64AttributeType
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TrashedIngredient")
        request.returnsObjectsAsFaults = false
        request.propertiesToGroupBy = ["trashToIngredient.name"]
        request.propertiesToFetch = [sumDesc]
        request.resultType = .dictionaryResultType
        
        do {
            let a = try moc.fetch(request)
            print(a)
        } catch {
            print(error.localizedDescription)
        }
    }
}

//struct TrashedIngredientSummary_Previews: PreviewProvider {
//    static var previews: some View {
//        TrashedIngredientSummary()
//    }
//}
