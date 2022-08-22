//
//  IngredientList.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 21/08/22.
//

import SwiftUI

struct IngredientList: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var groceryVM: GroceryViewModel = .init()
    
    @State var searchKeyword : String = ""
    
    @Binding var selectedIngredients : [Ingredient]
    @Binding var ingredientList: [Ingredient]
    @Binding var categoryName: String
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(searchResult) { item in
                        let isActive = self.selectedIngredients.contains(item)
                        
                        IngredientPlanItem(ingredient: item, isActive: isActive) {
                            if isActive {
                                self.selectedIngredients.removeAll { $0.id?.uuidString == item.id?.uuidString
                                }
                            } else {
                                self.selectedIngredients.append(item)
                            }
                        }
                    }
                }
                .searchable(text: $searchKeyword, placement: .navigationBarDrawer(displayMode: .always), prompt: "What ingredients do you need?")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            if !selectedIngredients.isEmpty {
                                groceryVM.saveIngredientsToGrocery(ingredients: selectedIngredients)
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        } label: {
                            Text("Add To List")
                                .disabled(selectedIngredients.isEmpty)
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Close")
                                .foregroundColor(Color.red)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .background(Color.lightGray)
            .navigationTitle(categoryName)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var searchResult: [Ingredient] {
        if searchKeyword.isEmpty {
            return ingredientList
        } else {
            return ingredientList.filter { item in
                return String(item.name ?? "").contains(searchKeyword)
            }
        }
    }
}

struct IngredientList_Previews: PreviewProvider {
    static var previews: some View {
        let ingredient = Ingredient(context: PersistenceController.preview.container.viewContext)
        IngredientList(selectedIngredients: .constant([]), ingredientList: .constant([ingredient]), categoryName: .constant("Apa hayoo"))
    }
}
