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
                    DisclosureGroup {
                        LazyVGrid(columns: columns) {
                            ForEach(items) { item in
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
                    } label: {
                        HStack {
                            Image(systemName: "house")
                            VStack (alignment: .leading) {
                                Text("\(category.rawValue)")
                                    .font(.system(.title2, design: .rounded))
                                    .bold()
                                Text("caption")
                                    .font(.body)
                            }
                            Spacer()
                            Text("\(items.count) item(s)")
                                .font(.system(.title2, design: .rounded))
                        }
                        .foregroundColor(Color.categoryTitleColor)
                        .padding()
                    }
                    Divider()
                }
                .searchable(text: $ingredientVM.searchQuery, placement: .navigationBarDrawer(displayMode: .always), prompt: "What ingredients you need to buy?")
                .onChange(of: ingredientVM.searchQuery) { _ in
                    ingredientVM.searchIngredient()
                }
                .onSubmit(of: .search) {
                    ingredientVM.searchIngredient()
                }
            }
            .padding(.horizontal)
            .navigationTitle("Shopping Plan")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(false)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if !selectedIngredients.isEmpty {
                            groceryVM.saveIngredientsToGrocery(ingredients: selectedIngredients)
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Add")
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
    }
}

struct GroceryShoppingPlan_Previews: PreviewProvider {
    static var previews: some View {
        GroceryShoppingPlan()
    }
}
