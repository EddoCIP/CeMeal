//
//  GroceryShoppingPlan.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 18/08/22.
//

import SwiftUI

struct GroceryShoppingPlan: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var ingredientVM : IngredientViewModel = .init()
    @ObservedObject var groceryVM : GroceryViewModel = .init()
    
    @State var selectedIngredients: [Ingredient] = []
    @State var isExpand : Bool = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(IngredientCategoryEnum.allCases, id: \.self) { category in
                    let items = ingredientVM.groupedIngredientByCategory[category.rawValue] ?? []
                    DisclosureGroup(category.rawValue) {
                        LazyVGrid(columns: columns) {
                            ForEach(items) { item in
                                let isActive = self.selectedIngredients.contains(item)
                                
                                IngredientPlanItem(isActive: isActive) {
                                    if isActive {
                                        self.selectedIngredients.removeAll { $0.id?.uuidString == ""
                                        }
                                    } else {
                                        self.selectedIngredients.append(Ingredient())
                                    }
                                }
                            }
                        }
                    }
                }
                
                DisclosureGroup("Fruit", isExpanded: $isExpand) {
                    LazyVGrid(columns: columns) {
                        ForEach((1...10), id: \.self) { item in
                            let isActive = self.selectedIngredients.contains(Ingredient())
                            
                            IngredientPlanItem(isActive: isActive) {
                                if isActive {
                                    self.selectedIngredients.removeAll { $0.id?.uuidString == ""
                                    }
                                } else {
                                    self.selectedIngredients.append(Ingredient())
                                }
                            }
                        }
                    }
                }
                .searchable(text: $ingredientVM.searchQuery, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
                .onChange(of: ingredientVM.searchQuery) { _ in
                    ingredientVM.searchIngredient()
                }
                .onSubmit(of: .search) {
                    ingredientVM.searchIngredient()
                }
            }
            .navigationTitle("Shopping Plan")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(false)
            .navigationBarHidden(false)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if !selectedIngredients.isEmpty {
                            groceryVM.saveIngredientsToGrocery(ingredients: selectedIngredients)
                        }
                    } label: {
                        Text("Add")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("< Back")
                    }
                }
            }
        }
    }
}

struct GroceryShoppingPlan_Previews: PreviewProvider {
    static var previews: some View {
        GroceryShoppingPlan()
    }
}
