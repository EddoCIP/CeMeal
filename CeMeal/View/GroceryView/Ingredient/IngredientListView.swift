//
//  IngredientList.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 21/08/22.
//

import SwiftUI

struct IngredientListView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var ingredientListVM: IngredientListViewModel
    
    @Binding var selectedIngredients : [Ingredient]
    
    var categoryName: String = ""
    
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
                    Button {
                        ingredientListVM.isSheetActive.toggle()
                    } label: {
                        VStack {
                            Image(systemName: "plus")
                                .font(.title2)
                                .frame(width: 70, height: 70)
                                .background(Color(uiColor: UIColor(red: 211, green: 211, blue: 211, alpha: 100)))
                                .cornerRadius(90)
                                .shadow(color: Color.lightShadowColor, radius: 1, x: 2, y: 2)
                            Text("Create new" + "\n")
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                                .foregroundColor(Color.darkGreen)
                                .font(.system(size: 15, weight: .semibold, design: .default))
                        }
                    }
                    
                    ForEach(ingredientListVM.ingredientList) { item in
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
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            if !selectedIngredients.isEmpty {
                                ingredientListVM.saveIngredientsToGrocery(ingredients: selectedIngredients)
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
                .sheet(isPresented: $ingredientListVM.isSheetActive) {
                    InputIngredientView(categoryTitle: categoryName)
                }
            }
            .onAppear {
                self.ingredientListVM.categoryName = categoryName
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
        IngredientListView(selectedIngredients: .constant([]), categoryName: "Apa hayoo")
            .environmentObject(IngredientListViewModel())
    }
}
