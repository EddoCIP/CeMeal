//
//  IngredientCategoryView.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 19/08/22.
//

import SwiftUI

struct IngredientCategoryView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var ingredientCategoryVM: IngredientCategoryViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Ingredients")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.semiDarkGray.opacity(0.5))
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(IngredientCategoryEnum.allCases, id: \.self) { category in
                        let items = self.ingredientCategoryVM.groupedIngredientByCategory[category.rawValue] ?? []
                        IngredientCategoryItem(title: category.rawValue, count: items.count)
                            .onTapGesture {
                                self.ingredientCategoryVM.groupItem = items
                                self.ingredientCategoryVM.groupCategory = category.rawValue
                                ingredientCategoryVM.isSheetActive.toggle()
                            }
                    }
                }
            }
        }
        .searchable(text: $ingredientCategoryVM.searchQuery, placement: .navigationBarDrawer(displayMode: .always), prompt: "What ingredients do you need?")
        .padding(.horizontal)
        .sheet(isPresented: $ingredientCategoryVM.isSheetActive) {
            IngredientListView(selectedIngredients: $ingredientCategoryVM.selectedIngredient, ingredientList: ingredientCategoryVM.groupItem, categoryName: ingredientCategoryVM.groupCategory)
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
        .background(Color.lightGray)
        .navigationTitle("Your shopping plan")
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct IngredientCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientCategoryView()
            .environmentObject(IngredientCategoryViewModel())
    }
}
