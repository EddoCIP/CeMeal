//
//  GroceryViewModel.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 18/08/22.
//

import Foundation
import CoreData
import Combine

class GroceryViewModel: ObservableObject {
    @Published var groceries: [Grocery] = []
    
    @Published var isNavActive: Bool = false
    @Published var isSettingActive: Bool = false
    @Published var doneGroceries: [Grocery] = []
    
    private var cancellable: AnyCancellable?
    
    init() {
        loadGrocery()
        cancellable = NotificationCenter.default.publisher(for: NSManagedObjectContext.didSaveObjectsNotification, object: nil)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { _ in
                self.loadGrocery()
            })
    }
    
    func loadGrocery() {
        groceries = Grocery.getGroceries()
    }
    
    func saveGroceriesToStorage() {
        let moc = PersistenceController.shared.container.viewContext
        
        for item in doneGroceries {
            let storage = Storage(context: moc)
            
            storage.id = UUID()
            storage.quantity = item.quantity
            storage.storedDate = Date()
            storage.storedIngredient = item.groceryToIngredient
            
            moc.delete(item)
        }
        
        PersistenceController.shared.saveContext()
    }
    
    func removeIngredientFromGrocery(grocery: Grocery) {
        let moc = PersistenceController.shared.container.viewContext
        
        moc.delete(grocery)
        
        PersistenceController.shared.saveContext()
    }
    
    func increaseQuantity(grocery: Grocery) {
        grocery.quantity += 1
        
        PersistenceController.shared.saveContext()
    }
    
    func decreaseQuantity(grocery: Grocery) {
        grocery.quantity -= 1
        
        PersistenceController.shared.saveContext()
    }
}
