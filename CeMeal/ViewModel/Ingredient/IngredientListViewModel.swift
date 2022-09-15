//
//  IngredientViewModel.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 18/08/22.
//

import Foundation
import CoreData
import Combine

class IngredientListViewModel: ObservableObject {
    @Published var ingredientList : [Ingredient] = []
    @Published var searchResult : [Ingredient] = []
    @Published var searchQuery : String = ""
    
    @Published var isSheetActive: Bool = false
    @Published var categoryName: String = "" {
        didSet {
            loadIngredient()
        }
    }
    
    private var cancellable: AnyCancellable?
    
    init() {
        loadIngredient()
        cancellable = NotificationCenter.default.publisher(for: NSManagedObjectContext.didSaveObjectsNotification, object: nil)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { _ in
                self.loadIngredient()
            })
    }
    
    func loadIngredient() {
        ingredientList = Ingredient.getIngredientsByCategory(category: categoryName)
    }
    
    func saveIngredientsToGrocery(ingredients: [Ingredient]) {
        for item in ingredients {
            let grocery = Grocery(context: PersistenceController.shared.container.viewContext)
            
            grocery.id = UUID()
            grocery.groceryToIngredient = item
            grocery.quantity = 1
            grocery.isDone = false
        }
        
        PersistenceController.shared.saveContext()
    }
}
