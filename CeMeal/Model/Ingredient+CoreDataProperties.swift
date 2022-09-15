//
//  Ingredient+CoreDataProperties.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 12/09/22.
//
//

import Foundation
import CoreData


extension Ingredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient")
    }

    @NSManaged public var carefulAge: Int16
    @NSManaged public var category: String?
    @NSManaged public var goodAge: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var imageUrl: String?
    @NSManaged public var nama: String?
    @NSManaged public var name: String?
    @NSManaged public var ingredientToConsume: NSSet?
    @NSManaged public var ingredientToGrocery: Grocery?
    @NSManaged public var ingredientToStorage: NSSet?
    @NSManaged public var ingredientToTrash: NSSet?

}

// MARK: Generated accessors for ingredientToConsume
extension Ingredient {

    @objc(addIngredientToConsumeObject:)
    @NSManaged public func addToIngredientToConsume(_ value: ConsumedIngredient)

    @objc(removeIngredientToConsumeObject:)
    @NSManaged public func removeFromIngredientToConsume(_ value: ConsumedIngredient)

    @objc(addIngredientToConsume:)
    @NSManaged public func addToIngredientToConsume(_ values: NSSet)

    @objc(removeIngredientToConsume:)
    @NSManaged public func removeFromIngredientToConsume(_ values: NSSet)

}

// MARK: Generated accessors for ingredientToStorage
extension Ingredient {

    @objc(addIngredientToStorageObject:)
    @NSManaged public func addToIngredientToStorage(_ value: Storage)

    @objc(removeIngredientToStorageObject:)
    @NSManaged public func removeFromIngredientToStorage(_ value: Storage)

    @objc(addIngredientToStorage:)
    @NSManaged public func addToIngredientToStorage(_ values: NSSet)

    @objc(removeIngredientToStorage:)
    @NSManaged public func removeFromIngredientToStorage(_ values: NSSet)

}

// MARK: Generated accessors for ingredientToTrash
extension Ingredient {

    @objc(addIngredientToTrashObject:)
    @NSManaged public func addToIngredientToTrash(_ value: TrashedIngredient)

    @objc(removeIngredientToTrashObject:)
    @NSManaged public func removeFromIngredientToTrash(_ value: TrashedIngredient)

    @objc(addIngredientToTrash:)
    @NSManaged public func addToIngredientToTrash(_ values: NSSet)

    @objc(removeIngredientToTrash:)
    @NSManaged public func removeFromIngredientToTrash(_ values: NSSet)

}

extension Ingredient : Identifiable {
    static func getIngredients(queryName: String) -> [Ingredient] {
        let context = PersistenceController.shared.container.viewContext
        let request = NSFetchRequest<Ingredient>(entityName: "Ingredient")
        request.sortDescriptors = []
        request.shouldRefreshRefetchedObjects = true
        
        if !queryName.isEmpty {
            var predicate: NSPredicate
            
            predicate = NSPredicate(format: "name CONTAINS[c] %@", argumentArray: [queryName])
            request.predicate = predicate
        }
        
        do {
            return try context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
    
    static func getIngredientsByCategory(category: String) -> [Ingredient] {
        let context = PersistenceController.shared.container.viewContext
        let request = NSFetchRequest<Ingredient>(entityName: "Ingredient")
        request.sortDescriptors = []
        request.shouldRefreshRefetchedObjects = true
        
        if !category.isEmpty {
            var predicate: NSPredicate
            
            predicate = NSPredicate(format: "category CONTAINS[c] %@", argumentArray: [category])
            request.predicate = predicate
        }
        
        do {
            return try context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
    
    static func saveIngredient(category: String, inputName: String, imageUrl: String) {
        let context = PersistenceController.shared.container.viewContext
        
        let ingredient = Ingredient(context: context)
        ingredient.id = UUID()
        ingredient.name = inputName
        ingredient.imageUrl = imageUrl
        ingredient.category = category
        
        PersistenceController.shared.saveContext()
    }
}
