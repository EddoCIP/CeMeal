//
//  IngredientViewModel.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 18/08/22.
//

import Foundation
import CoreData

class IngredientViewModel: ObservableObject {
    @Published var ingredientList : [Ingredient] = []
    @Published var searchResult : [Ingredient] = []
    @Published var searchQuery : String = ""
    
    init() {
        loadIngredient()
        //        searchIngredient()
    }
    
    func loadIngredient() {
        let moc = PersistenceController.shared.container.viewContext
        
        let request = NSFetchRequest<Ingredient>(entityName: "Ingredient")
        request.sortDescriptors = []
        
        do {
            try ingredientList = moc.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func searchIngredient() {
        let moc = PersistenceController.shared.container.viewContext
        
        let request = NSFetchRequest<Ingredient>(entityName: "Ingredient")
        let sort = NSSortDescriptor()
        request.sortDescriptors = [sort]
        
        var predicate: NSPredicate
        
        predicate = NSPredicate(format: "name CONTAINS[c] %@", argumentArray: [self.searchQuery])
        request.predicate = predicate
        
        do {
            try self.searchResult = moc.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var ingredientSearchResult : [Ingredient] {
        if searchQuery.isEmpty {
            return ingredientList
        } else {
            return ingredientList.filter { item in
                return
                    String(item.name?.lowercased() ?? "").contains(searchQuery.lowercased()) ||
                String(item.nama?.lowercased() ?? "").contains(searchQuery.lowercased())
            }
        }
    }
    
    var groupedIngredientByCategory: Dictionary<String, [Array<Ingredient>.Element]> {
        return Dictionary(grouping: ingredientSearchResult) { $0.category ?? "" }
    }
}
