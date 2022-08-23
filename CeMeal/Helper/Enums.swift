//
//  Enums.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 18/08/22.
//

import Foundation
import SwiftUI

enum IngredientCategoryEnum: String, CaseIterable {
    case fruits = "Fruits"
    case vegetables = "Vegetables"
    case animalProduct = "Animal Products"
    case grainNuts = "Grains & Nuts"
    case herbSpices = "Herb and Spices"
    case liquidOils = "Liquid and Oils"
    case milkDairy = "Milk and Dairy"
    case mushrooms = "Mushrooms"
    case tubers = "Tubers"
}

let buttonWidth: CGFloat = 60

enum CellButtons: Identifiable {
    case edit
    case delete
    case save
    case info
    
    var id: String {
        return "\(self)"
    }
}

func getCategoryIcon(category: String) -> Image {
    switch category {
    case IngredientCategoryEnum.animalProduct.rawValue:
        return Image("animal")
    case IngredientCategoryEnum.fruits.rawValue:
        return Image("fruits")
    case IngredientCategoryEnum.grainNuts.rawValue:
        return Image("nuts")
    case IngredientCategoryEnum.herbSpices.rawValue:
        return Image("herb")
    case IngredientCategoryEnum.liquidOils.rawValue:
        return Image("oil")
    case IngredientCategoryEnum.milkDairy.rawValue:
        return Image("milk")
    case IngredientCategoryEnum.mushrooms.rawValue:
        return Image("mushroom")
    case IngredientCategoryEnum.tubers.rawValue:
        return Image("tub")
    case IngredientCategoryEnum.vegetables.rawValue:
        return Image("vege")
    default:
        return Image("")
    }
}
