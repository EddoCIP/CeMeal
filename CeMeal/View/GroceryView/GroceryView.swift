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
    @State var isSettingActive: Bool = false
    
    init() {
        UITableView.appearance().separatorColor = .clear
    }
    
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
                    Text(Image(systemName: "plus.square"))
                        .font(.custom("SF Compact Display", size: 36))
                        .fontWeight(.thin)
                        .foregroundColor(Color.darkGreen)
                        .onTapGesture {
                            isNavActive.toggle()
                        }
                }
                .padding(.horizontal)
                Divider()
                    .shadow(radius: 10)
                HStack {
                    Text("3 items")
                        .foregroundColor(Color.darkerGreen)
                    Spacer()
                    Button {
                        isSettingActive.toggle()
                    } label: {
                        Text("Settings")
                            .foregroundColor(Color.lightGreen)
                    }
                }
                .font(.caption)
                .padding(.horizontal)
                .if(groceries.isEmpty) { view in
                    view.hidden()
                }
                
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
                                .clipShape(RoundedCorner(radius: 20, corners: [.bottomLeft, .topLeft]))
                                .frame(height: 60)
                                .swipeActions {
                                    Button(role: .destructive, action: {
                                        
                                    }, label: {
                                        Image(systemName: "trash")
                                    })
                                }
                                .shadow(radius: 5)
                            HStack {
                                Spacer(minLength: 1)
                            }
                            .frame(height: 10)
                        }
                        .padding(.trailing, -20)
                    }
                    .listStyle(.plain)
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
