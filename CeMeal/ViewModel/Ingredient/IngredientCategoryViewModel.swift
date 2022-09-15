//
//  IngredientCategoryViewModel.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 12/09/22.
//

import Foundation

import CoreData
import Combine

class IngredientCategoryViewModel: ObservableObject {
    @Published var ingredientList : [Ingredient] = []
    @Published var searchQuery : String = "" {
        didSet {
            loadIngredient()
        }
    }
    @Published var isSheetActive: Bool = false
    @Published var selectedIngredient: [Ingredient] = []
    @Published var groupItem: [Ingredient] = []
    @Published var groupCategory: String = ""
    
    
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
        ingredientList = Ingredient.getIngredients(queryName: searchQuery)
    }
    
    var ingredientSearchResult : [Ingredient] {
        if searchQuery.isEmpty {
            return ingredientList
        } else {
            return ingredientList.filter { item in
                return
                    String(item.name?.lowercased() ?? "").contains(searchQuery.lowercased()) ||
                String(item.nama?.lowercased() ?? "").contains(searchQuery.lowercased())
            }
        }
    }
    
    var groupedIngredientByCategory: Dictionary<String, [Array<Ingredient>.Element]> {
        return Dictionary(grouping: ingredientList) { $0.category ?? "" }
    }
}
