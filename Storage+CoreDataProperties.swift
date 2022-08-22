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

    var age : Int {
        return Date().days(from: self.storedDate ?? Date())
    }
}

extension Storage : Identifiable {

}
