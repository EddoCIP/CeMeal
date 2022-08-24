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
    @State var doneGroceries: [Grocery] = []
    
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
                        .font(.system(size: 36))
//                        .font(.custom("SF Compact Display", size: 36))
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
                    Text("\(groceries.count) items")
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
                    VStack {
                        List {
                            ForEach(groceries) { item in
                                HStack {
                                    EmptyView()
                                }
                                .frame(height: 1)
                                GroceryItem(grocery: item, doneGroceries: $doneGroceries, isSettingActive: $isSettingActive)
                                    .swipeActions {
                                        Button(role: .destructive, action: {
                                            groceryVM.removeIngredientFromGrocery(grocery: item)
                                        }, label: {
                                            Image(systemName: "trash")
                                        })
                                        .tint(Color.red)
                                    }
                                    .frame(height: 80)
                                    .clipShape(RoundedCorner(radius: 17, corners: [.bottomLeft, .topLeft]))
                                    .shadow(radius: 5)
                                    .listRowInsets(EdgeInsets(top: -8, leading: 0, bottom: -8, trailing: 0))
                            }
                            .listRowBackground(Color.clear)
                            .padding(.leading, 10)
                        }
                        .listSectionSeparatorTint(.black, edges: .bottom)
                        .listItemTint(Color.clear)
                        .background(Color.clear)
                        .listStyle(.plain)
                        Button {
                            groceryVM.saveGroceriesToStorage(groceries: doneGroceries)
                            doneGroceries = []
                        } label: {
                            Text("Add to storage")
                                .frame(width: 209, height: 46)
                        }
                        .padding()
                        .buttonStyle(.borderedProminent)
                        .if(!isSettingActive) { button in
                            button.hidden()
                        }
                    }
                    .background(Color.clear)
                }
                NavigationLink(isActive: $isNavActive) {
                    ShoppingPlanV2()
                } label: {
                    Text("")
                }
                .hidden()
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isShowSheet) {
                GroceryShoppingPlan()
            }
            .background(Color.lightGray)
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
