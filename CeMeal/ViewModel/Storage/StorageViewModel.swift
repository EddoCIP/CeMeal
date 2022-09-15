//
//  StorageViewModel.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 22/08/22.
//

import Foundation
import CoreData
import Combine

class StorageViewModel: ObservableObject {
    @Published var consumeList : [ConsumedIngredient] = []
    @Published var trashList : [TrashedIngredient] = []
    @Published var isShowSheet: Bool = false
    @Published var storageList: [Storage] = []
    
    private var cancellable: AnyCancellable?
    
    init() {
        loadData()
        cancellable = NotificationCenter.default.publisher(for: NSManagedObjectContext.didSaveObjectsNotification, object: nil)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { _ in
                self.loadData()
            })
    }
    
    func loadData() {
        storageList = Storage.getStorages()
        consumeList = ConsumedIngredient.getConsumedList()
        trashList = TrashedIngredient.getTrashedList()
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
    
    var dashboardStorage: [Storage] {
        return mustThrowIngredient + safeToConsumeIngredient
    }
    
    func save() {
        do {
            try PersistenceController.shared.container.viewContext.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
