//
//  TabbedView.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 18/08/22.
//

import SwiftUI

struct TabbedView: View {
    @State private var selection: Int = 0
    
    var body: some View {
        TabView(selection: $selection) {
            StorageView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Storage")
                }
                .tag(0)
            
            GroceryView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("List")
                }
                .tag(1)
            HistoryView()
                .tabItem {
                    Image(systemName: "clock.arrow.circlepath")
                    Text("History")
                }
                .tag(2)
        }
    }
}

struct TabbedView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedView()
    }
}
