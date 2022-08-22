//
//  DataInitialization.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 18/08/22.
//

import Foundation
import CoreData

func loadIngredientFromCSV() {
    let context = PersistenceController.shared.container.viewContext
    guard let filePath = Bundle.main.path(forResource: "ingredients", ofType: "csv") else { return }
    
    var data = ""
    do {
        data = try String(contentsOfFile: filePath)
    } catch {
        print(error.localizedDescription)
        return
    }
    
    var rows : [String] = data.components(separatedBy: "\n")
    let columnCount = rows.first?.components(separatedBy: ",").count
    rows.removeFirst()
    
    for row in rows {
        let csvColumns : [String] = row.components(separatedBy: ",")
        if csvColumns.count == columnCount {
            let ingredient = Ingredient(context: context)
            ingredient.id = UUID()
            ingredient.name = csvColumns[1]
            ingredient.category = csvColumns[0]
            ingredient.imageUrl = csvColumns[5]
            ingredient.goodAge = Int16(csvColumns[3]) ?? 0
            ingredient.carefulAge = Int16(csvColumns[4]) ?? 0
        }
    }
    
    try? context.save()
}
