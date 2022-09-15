//
//  TrashedIngredient+CoreDataProperties.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 15/09/22.
//
//

import Foundation
import CoreData


extension TrashedIngredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrashedIngredient> {
        return NSFetchRequest<TrashedIngredient>(entityName: "TrashedIngredient")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var quantity: Int16
    @NSManaged public var trashedDate: Date?
    @NSManaged public var trashToIngredient: Ingredient?

}

extension TrashedIngredient : Identifiable {
    static func getTrashedList() -> [TrashedIngredient] {
        let context = PersistenceController.shared.container.viewContext
        let request = NSFetchRequest<TrashedIngredient>(entityName: "TrashedIngredient")
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
