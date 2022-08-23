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
            ingredient.nama = csvColumns[1]
            ingredient.name = csvColumns[2]
            ingredient.category = csvColumns[0]
            ingredient.goodAge = Int16(csvColumns[3]) ?? 0
            ingredient.carefulAge = Int16(csvColumns[4]) ?? 0
            if !csvColumns[5].isEmpty {
                let separated = csvColumns[5].components(separatedBy: "\r")
                
                ingredient.imageUrl = separated[0]
            }
        }
    }
    
    try? context.save()
}

func loadIngredientToStorage() {
    let context = PersistenceController.shared.container.viewContext
    
    let request = NSFetchRequest<Ingredient>(entityName: "Ingredient")
    request.sortDescriptors = []
    var ingredientList: [Ingredient]
    
    do {
        try ingredientList = context.fetch(request)
        
        for ingredient in ingredientList {
            let storage = Storage(context: context)
            storage.id = UUID()
            storage.storedDate = Calendar.current.date(byAdding: .day, value: -Int.random(in: 1...90), to: Date())
            storage.storedIngredient = ingredient
            storage.quantity = Int16.random(in: 1...5)
        }
        
        try context.save()
    } catch {
        print(error.localizedDescription)
    }
}

func setTrashedIngredient() {
    let context = PersistenceController.shared.container.viewContext
    
    let request = NSFetchRequest<Ingredient>(entityName: "Ingredient")
    request.sortDescriptors = []
    var ingredientList: [Ingredient]
    
    do {
        try ingredientList = context.fetch(request)
        
        for ingredient in ingredientList {
            let trashed = TrashedIngredient(context: context)
            trashed.id = UUID()
            trashed.quantity = 2
            trashed.trashToIngredient = ingredient
            trashed.trashedDate = Date()
        }
        
        try context.save()
    } catch {
        print(error.localizedDescription)
    }
}
