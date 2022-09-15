//
//  GroceryView.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 18/08/22.
//

import SwiftUI

struct GroceryView: View {
    @EnvironmentObject var groceryVM: GroceryViewModel
    
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
                        .fontWeight(.thin)
                        .foregroundColor(Color.darkGreen)
                        .onTapGesture {
                            self.groceryVM.isNavActive.toggle()
                        }
                }
                .padding(.horizontal)
                Divider()
                    .shadow(radius: 10)
                HStack {
                    Text("\(self.groceryVM.groceries.count) items")
                        .foregroundColor(Color.darkerGreen)
                    Spacer()
                    Button {
                        self.groceryVM.isSettingActive.toggle()
                    } label: {
                        Text("Settings")
                            .foregroundColor(Color.lightGreen)
                    }
                }
                .font(.caption)
                .padding(.horizontal)
                .if(self.groceryVM.groceries.isEmpty) { view in
                    view.hidden()
                }
                
                if self.groceryVM.groceries.isEmpty {
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
                            ForEach(self.groceryVM.groceries) { item in
                                GroceryItemView(grocery: item, doneGroceries: $groceryVM.doneGroceries, isSettingActive: $groceryVM.isSettingActive)
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
                                    .shadow(color: Color.lightShadowColor, radius: 1, x: 0, y: 2)
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
                            groceryVM.saveGroceriesToStorage()
                            groceryVM.doneGroceries = []
                        } label: {
                            Text("Add to storage")
                                .frame(width: 209, height: 46)
                        }
                        .padding()
                        .buttonStyle(.borderedProminent)
                        .if(!groceryVM.isSettingActive) { button in
                            button.hidden()
                        }
                    }
                    .background(Color.clear)
                }
                NavigationLink(isActive: $groceryVM.isNavActive) {
                    IngredientCategoryView()
                } label: {
                    Text("")
                }
                .hidden()
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.lightGray)
        }
    }
}

struct GroceryView_Previews: PreviewProvider {
    static var previews: some View {
        GroceryView()
            .environmentObject(GroceryViewModel())
    }
}
