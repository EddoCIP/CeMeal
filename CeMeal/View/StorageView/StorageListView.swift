//
//  StorageListView.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 22/08/22.
//

import SwiftUI

struct StorageListView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var storageListVM: StorageListViewModel
    
    var body: some View {
        NavigationView {
            List {
                if !storageListVM.mustThrowIngredient.isEmpty {
                    Section {
                        generateSectionContent(items: storageListVM.mustThrowIngredient)
                    } header: {
                        HStack {
                            Image(systemName: "exclamationmark.circle.fill")
                            Text("Throw away now!")
                                .font(.title3)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .foregroundColor(Color.darkRed)
                    }
                    .headerProminence(.increased)
                    .listRowBackground(Color.clear)
                    .listRowInsets(.init(top: 2, leading: 2, bottom: 2, trailing: 2))
                }
                
                if !storageListVM.safeToConsumeIngredient.isEmpty {
                    Section {
                        generateSectionContent(items: storageListVM.safeToConsumeIngredient)
                    } header: {
                        HStack {
                            Image(systemName: "fork.knife.circle.fill")
                            Text("Consume immeadiately!")
                                .font(.title3)
                                .fontWeight(.medium)
                            Spacer()
                        }
                    }
                    .headerProminence(.increased)
                    .listRowBackground(Color.clear)
                    .listRowInsets(.init(top: 2, leading: 2, bottom: 2, trailing: 2))
                }
                
                if !storageListVM.freshIngredient.isEmpty {
                    Section {
                        generateSectionContent(items: storageListVM.freshIngredient)
                    } header: {
                        HStack {
                            Image(systemName: "leaf.circle.fill")
                            Text("Still fresh!")
                                .font(.title3)
                                .fontWeight(.medium)
                            Spacer()
                        }
                    }
                    .headerProminence(.increased)
                    .listRowBackground(Color.clear)
                    .listRowInsets(.init(top: 2, leading: 2, bottom: 2, trailing: 2))
                }
            }
            .listStyle(.plain)
            .padding(.horizontal, 20)
            .background(Color.lightGray)
            .navigationTitle("All ingredients list")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Storage")
                        }
                        .foregroundColor(Color.darkGreen)
                    }
                }
            }
        }
    }
    
    func generateSectionContent(items: [Storage]) -> some View {
        ForEach(items) { item in
            IngredientlistCell(storage: item)
                .clipShape(RoundedCorner(radius: 7, corners: .allCorners))
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button {
                        storageListVM.moveToConsumed(storage: item)
                    } label: {
                        VStack {
                            Image(systemName: "fork.knife")
                            Text("Consumed")
                        }
                    }
                    .tint(Color.green)
                    
                    Button(role: .destructive, action: {
                        storageListVM.moveToThrashed(storage: item)
                    }, label: {
//                        VStack {
//                            Image(systemName: "trash")
                        Label("Trash", systemImage: "trash")
//                            Text("Trashed")
//                        }
                    })
                    .frame(width: 100, height: 100)
                    .tint(Color.red)
                }
                .shadow(color: Color.lightShadowColor, radius: 1, x: 2, y: 2)
//            HStack {
//                EmptyView()
//            }
//            .frame(height: 1)
        }
    }
}

struct StorageListView_Previews: PreviewProvider {
    static var previews: some View {
        StorageListView()
            .environmentObject(StorageListViewModel())
    }
}
