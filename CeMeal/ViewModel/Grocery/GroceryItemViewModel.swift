//
//  GroceryItemViewModel.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 14/09/22.
//

import Foundation

class GroceryItemViewModel: ObservableObject {
    func increaseQuantity(grocery: Grocery) {
        grocery.quantity += 1
        
        PersistenceController.shared.saveContext()
    }
    
    func decreaseQuantity(grocery: Grocery) {
        if grocery.quantity > 0 {
            grocery.quantity -= 1
            
            PersistenceController.shared.saveContext()
        }
    }
}
