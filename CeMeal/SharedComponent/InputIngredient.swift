//
//  InputIngredient.swift
//  CeMeal
//
//  Created by Rafik Lutfi on 24/08/22.
//

import SwiftUI

struct InputIngredient: View {
    var categoryTitle: String = ""
    @ObservedObject var ingredientVM: IngredientViewModel
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    
    @State var inputName: String = ""
    @State var imageUrl: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    CameraView(url: $imageUrl)
                        .foregroundColor(Color.black)
                        .background(Color.white)
                        .cornerRadius(90)
                        .frame(width: 75, height: 75)
                        .shadow(radius: 3)
                    VStack (alignment: .leading) {
                        Text("Category")
                            .font(.title3)
                        Text(categoryTitle)
                            .font(.title3)
                    }
                    Spacer()
                }
                .padding()
                HStack {
                    Text("My Ingredient")
                        .font(.system(.subheadline, design: .rounded))
                        .fontWeight(.semibold)
                    Spacer()
                    TextField("Ingredient's Name", text: $inputName)
                }
                .padding()
                .frame(width: 347, height: 40)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 7))
                .shadow(color: .black, radius: 1)
                Spacer()
            }
            
            .navigationTitle("New Ingredient")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Cancel", systemImage: "chevron.left")
                            .labelStyle(.titleAndIcon)
                            .foregroundColor(Color.darkRed)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        ingredientVM.createNewIngredient(category: categoryTitle, inputName: inputName, imageUrl: imageUrl)
                        dismiss()
                    } label: {
                        Text("Save")
//                            .foregroundColor(Color.darkGreen)
                    }
                }
            }
        }
        
    }
}

struct InputIngredient_Previews: PreviewProvider {
    static var previews: some View {
        InputIngredient(categoryTitle: "Animal Product", ingredientVM: .init())
    }
}
