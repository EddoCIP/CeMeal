//
//  TabbedView.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 18/08/22.
//

import SwiftUI

struct TabbedView: View {
    @FetchRequest(sortDescriptors: []) var ingredients : FetchedResults <Ingredient>
    
    @State private var selection: Int = 0
    
    init() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.shadowColor = .gray
        tabBarAppearance.selectionIndicatorTintColor = UIColor(Color.darkGreen)
        tabBarAppearance.backgroundColor = .white
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
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
        .tint(Color.darkerGreen)
        .onAppear {
            if ingredients.isEmpty {
                loadIngredientFromCSV()
                loadIngredientToStorage()
//                setTrashedIngredient()
            }
        }
    }
}

struct TabbedView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedView()
    }
}
