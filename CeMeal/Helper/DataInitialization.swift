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
    guard let filePath = Bundle.main.path(forResource: "Ingredients", ofType: "csv") else { return }
    
    var data = ""
    do {
        data = try String(contentsOfFile: filePath)
    } catch {
        print(error.localizedDescription)
        return
    }
    
    var rows = data.components(separatedBy: "\n")
    let columnCount = rows.first?.components(separatedBy: ",").count
    rows.removeFirst()
    
    for row in rows {
        let csvColumns = row.components(separatedBy: ",")
        if csvColumns.count == columnCount {
            let ingredient = Ingredient(context: context)
            ingredient.id = UUID()
            ingredient.name = ""
            ingredient.category = ""
            ingredient.imageUrl = ""
        }
    }
    
    try? context.save()
}
