//
//  IngredientlistCell.swift
//  CeMeal
//
//  Created by Rafik Lutfi on 22/08/22.
//

import SwiftUI

struct IngredientlistCell: View {
    var body: some View {
        
        HStack {
            Rectangle()
                .foregroundColor(Color.mint)
                .frame(width: 90, height: 85)
            Spacer()
            VStack (alignment: .leading) {
                Text("Asparagus").font(.body).fontWeight(.heavy).foregroundColor(Color.black).bold()
                Divider()
                    
                Text("* 14 days old").font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.green).bold()
            }
            Spacer()
            Rectangle()
                .foregroundColor(Color.white)
                .frame(width: 100, height: 85)
                .overlay(Text("2 Qty")
                    .fontWeight(.semibold))
            
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
        .padding()
        
    }
}

struct IngredientlistCell_Previews: PreviewProvider {
    static var previews: some View {
        IngredientlistCell()
    }
}
