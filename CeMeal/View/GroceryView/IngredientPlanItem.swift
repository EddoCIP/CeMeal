//
//  IngredientPlanItem.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 18/08/22.
//

import SwiftUI

struct IngredientPlanItem: View {
    var isActive: Bool = false
    var action: () -> Void
    
    var body: some View {
        VStack {
            Text("Apple")
            RoundedImage(isActive: isActive)
        }
        .onTapGesture {
            action()
        }
    }
}

struct IngredientPlanItem_Previews: PreviewProvider {
    static var previews: some View {
        IngredientPlanItem() {
            
        }
    }
}
