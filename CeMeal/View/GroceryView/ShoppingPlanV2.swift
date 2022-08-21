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
                Text("LIST INGREDIENTS")
                    .font(.custom("SF Compact Display", size: 20))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.semiDarkGray)
                LazyVGrid(columns: columns) {
                    ForEach(IngredientCategoryEnum.allCases, id: \.self) { category in
                        let items = ingredientVM.groupedIngredientByCategory[category.rawValue] ?? []
                        CategoryView(title: category.rawValue, count: items.count)
                            .onTapGesture {
                                self.groupItem = items
                                self.groupCategory = category.rawValue
                                isSheetActive.toggle()
                            }
                    }
                }
            }
        }
        .padding(.horizontal)
        .sheet(isPresented: $isSheetActive) {
            IngredientListV2(selectedIngredients: $selectedIngredients, ingredientList: $groupItem, categoryName: $groupCategory)
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

struct CategoryView: View {
    var title: String
    var count: Int
    
    var body: some View {
        ZStack {
            RoundedCorner(radius: 15, corners: .allCorners)
                .fill(Color.gray)
                .opacity(0.5)
            VStack {
                Image(systemName: "house.fill")
                Text("\(count) item(s)")
                    .font(.caption)
            }
            .padding()
        }
        .frame(width: 100, height: 100)
    }
}

struct IngredientListV2: View {
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
            VStack {
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
                Spacer()
                    .searchable(text: $searchKeyword, placement: .navigationBarDrawer(displayMode: .always), prompt: "What ingredients do you need?")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                if !selectedIngredients.isEmpty {
                                    groceryVM.saveIngredientsToGrocery(ingredients: selectedIngredients)
                                }
                                self.presentationMode.wrappedValue.dismiss()
                            } label: {
                                Text("Add To List")
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

struct ShoppingPlanV2_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingPlanV2()
    }
}
