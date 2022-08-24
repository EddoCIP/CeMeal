//
//  CameraView.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 24/08/22.
//

import SwiftUI

struct CameraView: View {
    @State private var showImagePicker: Bool = false
    @State private var image: Image? = nil
    @State private var showConfirmationDialog : Bool = false
    @State private var imagePickerMode = 0
    
    @Binding var url: String
    
    var body: some View {
        VStack {
            Button {
                self.showConfirmationDialog = true
            } label: {
                if image != nil {
                    image?.resizable()
                } else {
                    Image(systemName: "camera").resizable().padding()
                }
            }
//            .frame(width: 75, height: 75)
//            .padding()
//            .background(.white)
//            .cornerRadius(90)
        }.sheet(isPresented: self.$showImagePicker) {
            ImagePicker(isShown: $showImagePicker, image: $image, imageUrl: $url, pickerMode: imagePickerMode)
        }.confirmationDialog("Testing", isPresented: $showConfirmationDialog) {
            Button("Choose Photo") {
                self.showImagePicker = true
                self.imagePickerMode = 0
            }
            Button("Take Photo") {
                self.showImagePicker = true
                self.imagePickerMode = 1
            }
            Button("Cancel", role: .cancel) {
                
            }
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView(url: .constant(""))
    }
}
