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
                Section {
                    ForEach(storageVM.mustThrowIngredient) { item in
                        Text("\(item.storedIngredient?.name ?? "Unknown")")
                    }
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
                
                Section {
                    ForEach(storageVM.safeToConsumeIngredient) { item in
                        Text("\(item.storedIngredient?.name ?? "Unknown")")
                    }
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
                
                Section {
                    ForEach(storageVM.freshIngredient) { item in
                        IngredientlistCell(storage: item)
                            .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
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
                            .padding(.vertical)
                            .shadow(color: .black, radius: 4, x: -2, y: 1)
                    }
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
                .listRowBackground(Color.white)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
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
}

struct StorageListView_Previews: PreviewProvider {
    static var previews: some View {
        StorageListView()
    }
}
