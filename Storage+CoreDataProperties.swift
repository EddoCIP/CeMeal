//
//  Storage+CoreDataProperties.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 22/08/22.
//
//

import Foundation
import CoreData


extension Storage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Storage> {
        return NSFetchRequest<Storage>(entityName: "Storage")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var quantity: Int16
    @NSManaged public var storedDate: Date?
    @NSManaged public var expireDate: Date?
    @NSManaged public var storedIngredient: Ingredient?

    public var age : Int {
        return Date().days(from: self.storedDate ?? Date())
    }
    
    public var isGood: Bool {
        return age <= storedIngredient?.goodAge ?? 0
    }
    
    public var isSafe: Bool {
        return age > storedIngredient?.goodAge ?? 0 && age <= storedIngredient?.carefulAge ?? 0
    }
    
    public var isDanger: Bool {
        return age > storedIngredient?.carefulAge ?? 0
    }
}

extension Storage : Identifiable {
    static func getStorages() -> [Storage] {
        let context = PersistenceController.shared.container.viewContext
        let request = NSFetchRequest<Storage>(entityName: "Storage")
        request.sortDescriptors = []
        request.shouldRefreshRefetchedObjects = true
        
        do {
            return try context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
}
