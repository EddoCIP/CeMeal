//
//  AsyncImageView.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 24/08/22.
//

import SwiftUI

struct AsyncImageView: View {
    var imageUrl: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { phase in
            if let image = phase.image {
                image.resizable()
            } else if phase.error != nil {
                if imageUrl.count != 0 {
                    let pngURL = URL(fileURLWithPath: imageUrl)
                    if let data = try? Data(contentsOf: pngURL, options: [.mappedIfSafe, .uncached]) {
                        Image(uiImage: UIImage(data: data)!)
                            .resizable()
                    } else {
                        Color.white
                    }
                } else {
                    Color.white
                }
            } else {
                ProgressView()
            }
        }
    }
}
//
//struct AsyncImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        AsyncImageView()
//    }
//}
