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
            HistoryView()
                .tabItem {
                    Image(systemName: "signpost.left")
                    Text("History")
                }
                .tag(2)
            ShoppingPlanV2()
                .tabItem {
                    Image(systemName: "signpost.left")
                    Text("Shopping Plan V2")
                }
                .tag(3)
        }
        .onAppear {
            if ingredients.isEmpty {
                print("masuk")
                loadIngredientFromCSV()
            }
        }
    }
}

struct TabbedView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedView()
    }
}
