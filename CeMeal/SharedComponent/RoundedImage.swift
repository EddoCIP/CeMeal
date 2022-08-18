//
//  RoundedImage.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 18/08/22.
//

import SwiftUI

struct RoundedImage: View {
    var size: CGFloat = 50
    var cornerRadius: CGFloat = 90
    var shownImage: Image = Image(systemName: "photo")
    var isActive : Bool
    
    var body: some View {
        shownImage
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(size > 100 ? 25 : 8)
            .frame(width: size, height: size)
            .background(Color.gray)
            .if(isActive) { view in
                view.overlay(
                    Circle()
                        .stroke(Color.green, lineWidth: 10)
                )
            }
            .cornerRadius(cornerRadius)
    }
}

struct RoundedImage_Previews: PreviewProvider {
    static var previews: some View {
        RoundedImage(cornerRadius: 90, isActive: true)
    }
}
