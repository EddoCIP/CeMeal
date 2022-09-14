//
//  Grocery+CoreDataProperties.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 14/09/22.
//
//

import Foundation
import CoreData


extension Grocery {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Grocery> {
        return NSFetchRequest<Grocery>(entityName: "Grocery")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isDone: Bool
    @NSManaged public var quantity: Int16
    @NSManaged public var groceryToIngredient: Ingredient?

}

extension Grocery : Identifiable {
    static func getGroceries() -> [Grocery] {
        let context = PersistenceController.shared.container.viewContext
        let request = NSFetchRequest<Grocery>(entityName: "Grocery")
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
