//
//  StorageView.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 18/08/22.
//

import SwiftUI

struct StorageView: View {
    @StateObject var storageVM : StorageViewModel = .init()
    
    @State private var isShowSheet: Bool = false
    
    let rows = [
        GridItem(.flexible(minimum: 230, maximum: 300))
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.darkerGreen.ignoresSafeArea()
                VStack {
                    HStack{
                        Spacer()
                    }
                    .frame(height: UINavigationBar.appearance().bounds.height)
                    HStack {
                        Text("Storage")
                            .font(.system(size: 34, weight: .light, design: .rounded))
                            .foregroundColor(Color.lighterOrange)
                        Spacer()
                        Button {
                            isShowSheet.toggle()
                        } label: {
                            Text("view all ingredients")
                                .font(.custom("SF Pro Display", size: 13))
                                .padding(10)
                                .foregroundColor(Color.darkGreen)
                                .background(Color.white)
                                .clipShape(
                                    RoundedCorner(radius: 14.5, corners: [.topLeft, .topRight]))
                        }
                        .offset(y: 27)
                    }
                    Divider()
                        .background(Color.white)
                        .shadow(radius: 10)
                    HStack {
                        Spacer()
                        Text("\(storageVM.storageList.count) item(s)")
                            .foregroundColor(Color.lightGreen)
                            .font(.caption)
                            .fontWeight(.bold)
                    }
                    
                    if storageVM.mustThrowIngredient.isEmpty {
                        VStack(spacing: 15) {
                            Spacer()
                            Image("vegetables")
                                .resizable()
                                .frame(width: 127, height: 127)
                                .foregroundColor(Color.lightOrange)
                            Text("your ingredients are safe!")
                                .foregroundColor(Color.lightOrange)
                                .font(.callout)
                                .bold()
                            Spacer()
                        }
                    } else {
                        dashboardWithIngredients()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .padding(.horizontal)
                .sheet(isPresented: $isShowSheet) {
                    StorageListView()
                }
            }
        }
        .onAppear {
            storageVM.loadStorage()
        }
    }
    
    func subTitleDashboard(subtitle: String) -> some View {
        VStack {
            Divider()
                .background(Color.white)
                .shadow(radius: 10)
            HStack {
                Text(subtitle)
                    .newYorkFont(size: 16)
                    .foregroundColor(Color.white.opacity(0.71))
                Spacer()
            }
            Divider()
                .background(Color.white)
                .shadow(radius: 10)
        }
    }
    
    func dashboardWithIngredients() -> some View {
        VStack {
            subTitleDashboard(subtitle: "Items that need special attention")
            ScrollView(.horizontal, showsIndicators: true) {
                LazyHGrid(rows: rows) {
                    ForEach(storageVM.dashboardStorage) { item in
                        MainMenuCard(storage: item)
                    }
                }
            }
            Spacer()
            subTitleDashboard(subtitle: "Your Food History")
            Spacer()
            ConsumedIngredientSummary()
            .padding()
            .frame(width: 340, height: 90)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            TrashedIngredientSummary()
            .padding()
            .frame(width: 340, height: 90)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            Spacer()
        }
    }
}

struct StorageView_Previews: PreviewProvider {
    static var previews: some View {
        StorageView()
    }
}
