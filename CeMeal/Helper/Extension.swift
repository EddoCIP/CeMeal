//
//  Extension.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 18/08/22.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

extension Color {
    static let listColor = Color("ListColor")
    static let categoryTitleColor = Color("CategoryTilteColor")
    static let darkGreen = Color("DarkGreen")
    static let semiDarkGray = Color("SemiDarkGrey")
    static let lightGray = Color("LightGray")
}

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

extension Text {
    func compactFont(size: Int) -> Text {
        return self.font(.custom("SF Compact Display", size: CGFloat(size)))
    }
}
