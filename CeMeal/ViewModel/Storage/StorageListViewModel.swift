//
//  StorageListViewModel.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 15/09/22.
//

import Foundation
import CoreData
import Combine

class StorageListViewModel: ObservableObject {
    @Published var storageList: [Storage] = []
    
    private var cancellable: AnyCancellable?
    
    init() {
        loadStorage()
        cancellable = NotificationCenter.default.publisher(for: NSManagedObjectContext.didSaveObjectsNotification, object: nil)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { _ in
                self.loadStorage()
            })
    }
    
    func loadStorage() {
        storageList = Storage.getStorages()
    }
    
    var mustThrowIngredient : [Storage] {
        return storageList.filter { storedItem in
            return storedItem.isDanger
        }
        .sorted { $0.age > $1.age }
    }
    
    var safeToConsumeIngredient: [Storage] {
        return storageList.filter { storedItem in
            return storedItem.isSafe
        }
        .sorted { $0.age > $1.age }
    }
    
    var freshIngredient: [Storage] {
        return storageList.filter { storedItem in
            return storedItem.isGood
        }
        .sorted { $0.age > $1.age }
    }
    
    func moveToConsumed(storage: Storage) {
        let moc = PersistenceController.shared.container.viewContext
        
        let consumedIngredient = ConsumedIngredient(context: moc)
        
        consumedIngredient.id = UUID()
        consumedIngredient.consumedDate = Date()
        consumedIngredient.quantity = storage.quantity
        consumedIngredient.consumeToIngredient = storage.storedIngredient
        
        moc.delete(storage)
        save()
    }
    
    func moveToThrashed(storage: Storage) {
        let moc = PersistenceController.shared.container.viewContext
        
        let trashedIngredient = TrashedIngredient(context: moc)
        
        trashedIngredient.id = UUID()
        trashedIngredient.trashedDate = Date()
        trashedIngredient.quantity = storage.quantity
        trashedIngredient.trashToIngredient = storage.storedIngredient
        
        moc.delete(storage)
        save()
    }
    
    func save() {
        PersistenceController.shared.saveContext()
    }
}
