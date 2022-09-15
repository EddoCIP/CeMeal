//
//  CeMealApp.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 18/08/22.
//

import SwiftUI

@main
struct CeMealApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var ingredientListVM : IngredientListViewModel = .init()
    @StateObject var ingredientCategoryVM: IngredientCategoryViewModel = .init()
    @StateObject var inputIngredientVM: InputIngredientViewModel = .init()
    @StateObject var groceryVM: GroceryViewModel = .init()
    @StateObject var groceryItemVM: GroceryItemViewModel = .init()
    @StateObject var storageVM: StorageViewModel = .init()
    @StateObject var storageListVM: StorageListViewModel = .init()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(ingredientListVM)
                .environmentObject(ingredientCategoryVM)
                .environmentObject(inputIngredientVM)
                .environmentObject(groceryVM)
                .environmentObject(groceryItemVM)
                .environmentObject(storageVM)
                .environmentObject(storageListVM)
//            LocalNotification()
        }
    }
}
