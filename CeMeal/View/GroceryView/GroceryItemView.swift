//
//  GroceryItem.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 18/08/22.
//

import SwiftUI

struct GroceryItemView: View {
    @Environment(\.locale) var locale
    
    var grocery: Grocery
    @Binding var doneGroceries: [Grocery]
    @Binding var isSettingActive: Bool
    @State var showStepper: Bool = false
    
    @ObservedObject var groceryVM : GroceryViewModel
    
    var body: some View {
        ZStack {
            let isDone = self.doneGroceries.contains(grocery)
            ZStack {
                HStack {
                    Spacer()
                    Rectangle()
                        .foregroundColor(Color.white)
                        .frame(height: 60)
                        .clipShape(RoundedCorner(radius: 18, corners: [.bottomLeft, .topLeft]))
                        .offset(x: 10)
                }
                // End of rounded rectangle
                HStack {
                    HStack {
                        Spacer()
                        AsyncImageView(imageUrl: grocery.groceryToIngredient?.imageUrl ?? "")
                        .frame(width: 52, height: 52)
                    }
                    .frame(width: 96, height: 60)
                    Text("\(locale == Locale.init(identifier: "id") ? grocery.groceryToIngredient?.nama ?? grocery.groceryToIngredient?.name ?? "Unknown" : grocery.groceryToIngredient?.name ?? "Unknown")")
                        .font(.title2)
                        .if(isDone && isSettingActive) { view in
                            view.strikethrough()
                        }
                    Spacer()
                    VStack {
                        RoundedCorner(radius: 18, corners: .allCorners)
                            .foregroundColor(Color.lightGray)
                            .frame(width: 69, height: 34)
                            .overlay(Text("\(grocery.quantity)")
                                .fontWeight(.bold))
                            .padding(showStepper ? .horizontal : .all)
                            .onTapGesture {
                                showStepper.toggle()
                            }
//                            .shadow(radius: 2)
                        if showStepper {
                            StepperGrocery {
                                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                    impactMed.impactOccurred()
                                impactMed.impactOccurred()
                                groceryVM.decreaseQuantity(grocery: grocery)
                            } onIncrease: {
                                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                    impactMed.impactOccurred()
                                impactMed.impactOccurred()
                                groceryVM.increaseQuantity(grocery: grocery)
                            }
                        }
                    }
                }
            }
            HStack {
                Circle()
                    .foregroundColor(Color.white)
                    .frame(width: 33, height: 33)
                    .overlay {
                        if isDone {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .foregroundColor(Color.lightGreen)
                                .background(Color.clear)
                        } else {
                            Circle()
                                .frame(width: 28, height: 28)
                                .foregroundColor(Color.lightGray)
                        }
                    }
                    .opacity(isSettingActive ? 1 : 0)
                Spacer()
            }
            .onTapGesture {
                if isDone {
                    self.doneGroceries.removeAll { $0.id?.uuidString == grocery.id?.uuidString
                    }
                } else {
                    self.doneGroceries.append(grocery)
                }
            }
            .if(!isSettingActive) { view in
                view.hidden()
            }
        }
        .frame(height: 60)
    }
}

struct GroceryItem_Previews: PreviewProvider {
    static var previews: some View {
        GroceryItemView(grocery: Grocery(context: PersistenceController.preview.container.viewContext),
                    doneGroceries: .constant([]),
                    isSettingActive: .constant(true),
                    groceryVM: .init())
    }
}
