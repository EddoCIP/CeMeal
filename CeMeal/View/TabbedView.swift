//
//  TabbedView.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 18/08/22.
//

import SwiftUI

struct TabbedView: View {
    @EnvironmentObject var ingredientVM: IngredientListViewModel
    
    @State private var selection: Int = 0
    
    init() {
        UITabBar.appearance().backgroundColor = .white
//        UITabBar.appearance().unselectedItemTintColor = .systemCyan
        UITabBar.appearance().isOpaque = false
    }
    
    var body: some View {
        TabView(selection: $selection) {
            StorageView()
                .tabItem {
                    Image(systemName: "archivebox")
                    Text("Storage")
                }
                .tag(0)
            
            GroceryView()
                .tabItem {
                    Image(systemName: "doc.append")
                    Text("List")
                }
                .tag(1)
        }
        .onAppear {
            if ingredientVM.ingredientList.isEmpty {
                loadIngredientFromCSV()
//                loadIngredientToStorage()
//                setTrashedIngredient()
            }
        }
    }
}

struct TabbedView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedView()
            .environmentObject(IngredientListViewModel())
            .environmentObject(StorageViewModel())
            .environmentObject(GroceryViewModel())
    }
}
