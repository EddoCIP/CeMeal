//
//  StorageListView.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 22/08/22.
//

import SwiftUI

struct StorageListView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var storageVM: StorageViewModel = .init()
    
    var body: some View {
        NavigationView {
            List {
                if !storageVM.mustThrowIngredient.isEmpty {
                    Section {
                        generateSectionContent(items: storageVM.mustThrowIngredient)
                    } header: {
                        HStack {
                            Image(systemName: "exclamationmark.circle.fill")
                            Text("Throw away now!")
                                .newYorkFont(size: 20)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .foregroundColor(Color.darkRed)
                    }
                    .headerProminence(.increased)
                    .listRowBackground(Color.clear)
                }
                
                if !storageVM.safeToConsumeIngredient.isEmpty {
                    Section {
                        generateSectionContent(items: storageVM.safeToConsumeIngredient)
                    } header: {
                        HStack {
                            Image(systemName: "fork.knife.circle.fill")
                            Text("Consume immeadiately!")
                                .newYorkFont(size: 20)
                                .fontWeight(.medium)
                            Spacer()
                        }
                    }
                    .headerProminence(.increased)
                    .listRowBackground(Color.clear)
                }
                
                if !storageVM.freshIngredient.isEmpty {
                    Section {
                        generateSectionContent(items: storageVM.freshIngredient)
                    } header: {
                        HStack {
                            Image(systemName: "leaf.circle.fill")
                            Text("Still fresh!")
                                .newYorkFont(size: 20)
                                .fontWeight(.medium)
                            Spacer()
                        }
                    }
                    .headerProminence(.increased)
                    .listRowBackground(Color.clear)
                    .listRowInsets(.init(top: 5, leading: 2, bottom: 2, trailing: 2))
                }
            }
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
                        
                    } label: {
                        VStack {
                            Image(systemName: "fork.knife")
                            Text("Consumed")
                        }
                    }
                    .tint(Color.green)
                    
                    Button(role: .destructive, action: {
                        
                    }, label: {
                        VStack {
                            Image(systemName: "trash")
                            Text("Trashed")
                        }
                    })
                    .tint(Color.red)
                }
                .shadow(color: .black, radius: 2, x: 0, y: 2)
        }
    }
}

struct StorageListView_Previews: PreviewProvider {
    static var previews: some View {
        StorageListView()
    }
}
