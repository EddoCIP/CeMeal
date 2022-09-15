//
//  StorageView.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 18/08/22.
//

import SwiftUI

struct StorageView: View {
    @EnvironmentObject var storageVM : StorageViewModel
    
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
                            self.storageVM.isShowSheet.toggle()
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
                    VStack {
                        attentionDashboard()
                            .background(Color.darkGreen.opacity(0.5))
                            .cornerRadius(20)
                            .padding(.horizontal)
                            .padding(.bottom, 10)
                        
                        foodHistoryDashboard()
                            .background(Color.darkGreen.opacity(0.5))
                            .cornerRadius(20)
                            .padding(.horizontal)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
//                .navigationBarHidden(true)
                .padding(.horizontal)
                .padding(.bottom, 20)
                .sheet(isPresented: $storageVM.isShowSheet) {
                    StorageListView()
                }
            }
        }
    }
    
    func attentionDashboard() -> some View {
        VStack {
            HStack {
                Text("Items that need special attention")
                    .font(.callout)
                    .foregroundColor(Color.white.opacity(0.71))
                Spacer()
            }
            .padding(.leading, 15)
            .padding(.top, 10)
            
            if storageVM.dashboardStorage.isEmpty {
                VStack(spacing: 15) {
                    Spacer()
                    Image("vegetables")
                        .resizable()
                        .frame(width: 108, height: 108)
                        .foregroundColor(Color.lightOrange)
                    Text("your ingredients are safe!")
                        .foregroundColor(Color.lightOrange.opacity(0.5))
                        .font(.callout)
                        .bold()
                    Spacer()
                }
            } else {
                ScrollView(.horizontal, showsIndicators: true) {
                    LazyHGrid(rows: rows) {
                        ForEach(storageVM.dashboardStorage) { item in
                            MainMenuCard(storage: item)
                        }
                    }
                }
            }
        }
        .padding(.bottom, 15)
    }
    
    func foodHistoryDashboard() -> some View {
        VStack {
            HStack {
                Text("Your food history")
                    .font(.callout)
                    .foregroundColor(Color.white.opacity(0.71))
                Spacer()
            }
            .padding(.leading, 15)
            .padding(.top, 10)
            
            if storageVM.consumeList.isEmpty && storageVM.trashList.isEmpty {
                VStack(alignment: .center) {
                    Spacer()
                    Text("no food history")
                        .foregroundColor(Color.lightOrange.opacity(0.5))
                        .font(.callout)
                        .bold()
                    Spacer()
                }
            } else {
                VStack {
                    ConsumedIngredientSummary()
                    .padding()
                    .frame(height: 90)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    TrashedIngredientSummary()
                    .padding()
                    .frame(height: 90)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
    }
}

struct StorageView_Previews: PreviewProvider {
    static var previews: some View {
        StorageView()
            .environmentObject(StorageViewModel())
    }
}
