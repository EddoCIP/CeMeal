//
//  ConsumedIngredient+CoreDataProperties.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 15/09/22.
//
//

import Foundation
import CoreData


extension ConsumedIngredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ConsumedIngredient> {
        return NSFetchRequest<ConsumedIngredient>(entityName: "ConsumedIngredient")
    }

    @NSManaged public var consumedDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var quantity: Int16
    @NSManaged public var consumeToIngredient: Ingredient?

}

extension ConsumedIngredient : Identifiable {
    static func getConsumedList() -> [ConsumedIngredient] {
        let context = PersistenceController.shared.container.viewContext
        let request = NSFetchRequest<ConsumedIngredient>(entityName: "ConsumedIngredient")
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
