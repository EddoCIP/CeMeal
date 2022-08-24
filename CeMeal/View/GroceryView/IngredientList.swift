//
//  IngredientList.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 21/08/22.
//

import SwiftUI

struct IngredientList: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var ingredientVM: IngredientViewModel
    @ObservedObject var groceryVM: GroceryViewModel
    
    @State var searchKeyword : String = ""
    @State var isSheetActive: Bool = false
    
    @Binding var selectedIngredients : [Ingredient]
    var ingredientList: [Ingredient] = []
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
                    ForEach(ingredientList) { item in
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
                .padding(.bottom, 20)
                Button {
                    isSheetActive.toggle()
                } label: {
                    Text("Custom create")
                        .foregroundColor(Color.white)
                        .font(.callout)
                        .fontWeight(.bold)
                        .frame(width: 209, height: 46)
                        .background(Color.darkGreen)
                        .cornerRadius(7)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            if !selectedIngredients.isEmpty {
                                groceryVM.saveIngredientsToGrocery(ingredients: selectedIngredients)
                                self.presentationMode.wrappedValue.dismiss()
                                selectedIngredients = []
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
                .sheet(isPresented: $isSheetActive) {
                    InputIngredient(categoryTitle: categoryName, ingredientVM: ingredientVM)
                }
            }
            .padding(.horizontal)
            .background(Color.lightGray)
            .navigationTitle(categoryName)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct IngredientList_Previews: PreviewProvider {
    static var previews: some View {
        let ingredient = Ingredient(context: PersistenceController.preview.container.viewContext)
        IngredientList(ingredientVM: .init(), groceryVM: .init(), selectedIngredients: .constant([]), ingredientList: [ingredient], categoryName: .constant("Apa hayoo"))
    }
}
