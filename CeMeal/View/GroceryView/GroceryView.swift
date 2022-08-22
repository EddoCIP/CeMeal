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
    @FetchRequest(sortDescriptors: []) var groceries : FetchedResults <Grocery>
    
    @State var isNavActive: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    Spacer()
                }
                .frame(height: UINavigationBar.appearance().bounds.height)
                HStack {
                    Text("Grocery List")
                        .font(.system(size: 34, weight: .light, design: .rounded))
                        .foregroundColor(Color.darkGreen)
                    Spacer()
                    Image(systemName: "plus.square")
                        .font(.custom("SF Compact Display", size: 36))
                        .foregroundColor(Color.darkGreen)
                        .onTapGesture {
                            isNavActive.toggle()
                        }
                }
                Divider()
                    .shadow(radius: 10)
                
                if groceries.isEmpty {
                    VStack(spacing: 30) {
                        Spacer()
                        Image("shoppingCart")
                        Text("no shopping plan")
                            .foregroundColor(Color.lightOrange)
                            .font(.callout)
                            .bold()
                        Spacer()
                    }
                } else {
                    List {
                        ForEach(groceries) { item in
                            GroceryItem(grocery: item)
                        }
                    }.listStyle(.plain)
                }
            }
            .background {
                NavigationLink(isActive: $isNavActive) {
                    ShoppingPlanV2()
                } label: {
                    Text("")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal)
            .sheet(isPresented: $isShowSheet) {
                GroceryShoppingPlan()
            }
        }
    }
}
//
//struct GroceryView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroceryView()
//            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
