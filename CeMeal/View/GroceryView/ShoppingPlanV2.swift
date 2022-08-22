//
//  ShoppingPlanV2.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 19/08/22.
//

import SwiftUI

struct ShoppingPlanV2: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var ingredientVM : IngredientViewModel = .init()
    @ObservedObject var groceryVM : GroceryViewModel = .init()
    
    @State var selectedIngredients: [Ingredient] = []
    @State var groupItem : [Ingredient] = []
    @State var isSheetActive : Bool = false
    @State var groupCategory: String = ""
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Ingredients")
                    .newYorkFont(size: 20)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.semiDarkGray.opacity(0.5))
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(IngredientCategoryEnum.allCases, id: \.self) { category in
                        let items = ingredientVM.groupedIngredientByCategory[category.rawValue] ?? []
                        IngredientCategoryView(title: category.rawValue, count: items.count)
                            .onTapGesture {
                                self.groupItem = items
                                self.groupCategory = category.rawValue
                                isSheetActive.toggle()
                            }
                    }
                }
            }
        }
        .onAppear {
            ingredientVM.loadIngredient()
        }
        .padding(.horizontal)
        .sheet(isPresented: $isSheetActive) {
            IngredientList(selectedIngredients: $selectedIngredients, ingredientList: $groupItem.wrappedValue, categoryName: $groupCategory)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Cancel")
                    }
                    .foregroundColor(Color.red)
                }
            }
        }
        .navigationTitle("Your shopping plan")
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ShoppingPlanV2_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingPlanV2()
    }
}
