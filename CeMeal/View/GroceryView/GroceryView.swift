//
//  GroceryView.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 18/08/22.
//

import SwiftUI

struct GroceryView: View {
    @State var isShowSheet: Bool = false
    
    @ObservedObject var groceryVM: GroceryViewModel = .init()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    Spacer()
                }
                .frame(height: UINavigationBar.appearance().bounds.height)
                
                List {
                    ForEach(groceryVM.groceryList) { item in
                        GroceryItem(grocery: item)
                    }
                }
                .navigationTitle("Grocery List")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isShowSheet.toggle()
                        } label: {
                            Image(systemName: "plus.circle.fill")
                        }
                    }
                }
            }
            .sheet(isPresented: $isShowSheet) {
                GroceryShoppingPlan()
            }
        }
    }
}

struct GroceryView_Previews: PreviewProvider {
    static var previews: some View {
        GroceryView()
    }
}
