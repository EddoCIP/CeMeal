//
//  StorageViewModel.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 22/08/22.
//

import Foundation
import CoreData

class StorageViewModel: ObservableObject {
    @Published var storageList: [Storage] = []
    
    init() {
        loadStorage()
//        print(storageList)
    }
    
    func loadStorage() {
        let moc = PersistenceController.shared.container.viewContext
        
        let request = NSFetchRequest<Storage>(entityName: "Storage")
        request.sortDescriptors = []
        
        do {
            try storageList = moc.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func moveToConsumed(storage: Storage) {
        let moc = PersistenceController.shared.container.viewContext
        
        let consumedIngredient = ConsumedIngredient(context: moc)
        
        consumedIngredient.id = UUID()
        consumedIngredient.consumedDate = Date()
        consumedIngredient.quantity = storage.quantity
        consumedIngredient.consumeToIngredient = storage.storedIngredient
        
        moc.delete(storage)
        try? moc.save()
    }
    
    func moveToThrashed(storage: Storage) {
        let moc = PersistenceController.shared.container.viewContext
        
        let trashedIngredient = TrashedIngredient(context: moc)
        
        trashedIngredient.id = UUID()
        trashedIngredient.trashedDate = Date()
        trashedIngredient.quantity = storage.quantity
        trashedIngredient.trashToIngredient = storage.storedIngredient
        
        moc.delete(storage)
        try? moc.save()
    }
    
    var mustThrowIngredient : [Storage] {
        return storageList.filter { storedItem in
            let ingredientAge = Date().days(from: storedItem.storedDate ?? Date())
            
            return ingredientAge > storedItem.storedIngredient?.carefulAge ?? 0
        }
    }
    
    var safeToConsumeIngredient: [Storage] {
        return storageList.filter { storedItem in
            let isGood = storedItem.age <= storedItem.storedIngredient?.goodAge ?? 0
            let isCareful = storedItem.age <= storedItem.storedIngredient?.carefulAge ?? 0
            
            return isCareful && !isGood
        }
    }
    
    var freshIngredient: [Storage] {
        return storageList.filter { storedItem in
            return storedItem.age <= storedItem.storedIngredient?.goodAge ?? 0
        }
    }
}
