//
//  StorageListView.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 22/08/22.
//

import SwiftUI

struct StorageListView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var storegeVM: StorageViewModel = .init()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "exclamationmark.circle.fill")
                        Text("Throw away now!")
                            .newYorkFont(size: 20)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .foregroundColor(Color.darkRed)
                    List {
                        ForEach(storegeVM.mustThrowIngredient) { item in
                            EmptyView()
                        }
                    }
                    HStack {
                        Image(systemName: "fork.knife.circle.fill")
                        Text("Consume immeadiately!")
                            .newYorkFont(size: 20)
                            .fontWeight(.medium)
                        Spacer()
                    }
                    List {
                        ForEach(storegeVM.safeToConsumeIngredient) { item in
                            EmptyView()
                        }
                    }
                    HStack {
                        Image(systemName: "leaf.circle.fill")
                        Text("Still fresh!")
                            .newYorkFont(size: 20)
                            .fontWeight(.medium)
                        Spacer()
                    }
                }
                .padding()
            }
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
