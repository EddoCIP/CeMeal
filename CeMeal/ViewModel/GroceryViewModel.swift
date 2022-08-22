//
//  GroceryViewModel.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 18/08/22.
//

import Foundation
import CoreData

class GroceryViewModel: ObservableObject {
    @Published var groceryList: [Grocery] = []
    
    init() {
        loadGrocery()
    }
    
    func loadGrocery() {
        let moc = PersistenceController.shared.container.viewContext
        
        let request = NSFetchRequest<Grocery>(entityName: "Grocery")
        request.sortDescriptors = []
        
        do {
            try groceryList = moc.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveGroceriesToStorage(groceries: [Grocery]) {
        let moc = PersistenceController.shared.container.viewContext
        
        for item in groceries {
            let storage = Storage(context: moc)
            
            storage.id = UUID()
            storage.quantity = item.quantity
            storage.storedDate = Date()
            storage.storedIngredient = item.groceryToIngredient
            
            moc.delete(item)
        }
        
        save()
    }
    
    func saveIngredientsToGrocery(ingredients: [Ingredient]) {
        for item in ingredients {
            let grocery = Grocery(context: PersistenceController.shared.container.viewContext)
            
            grocery.id = UUID()
            grocery.groceryToIngredient = item
            grocery.quantity = 1
            grocery.isDone = false
        }
        
        save()
    }
    
    func save() {
        do {
            try PersistenceController.shared.container.viewContext.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func increaseQuantity(grocery: Grocery) {
        grocery.quantity += 1
        
        save()
    }
    
    func decreaseQuantity(grocery: Grocery) {
        grocery.quantity -= 1
        
        save()
    }
}
