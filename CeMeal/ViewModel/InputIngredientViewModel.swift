//
//  InputIngredientViewModel.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 12/09/22.
//

import Foundation
import CoreData

class InputIngredientViewModel: ObservableObject {
    @Published var inputName: String = ""
    @Published var imageUrl: String = ""
    
    func saveIngredient(category: String, inputName: String, imageUrl: String) {
        Ingredient.saveIngredient(category: category, inputName: inputName, imageUrl: imageUrl)
    }
}
