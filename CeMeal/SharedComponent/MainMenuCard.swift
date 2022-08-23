//
//  MainMenuCard.swift
//  CeMeal
//
//  Created by Rafik Lutfi on 23/08/22.
//

import SwiftUI

struct MainMenuCard: View {
    var body: some View {
        VStack {
            Text("Apple")
            
            Rectangle()
                .fill(Color.white)
                .frame(width: 100, height: 95, alignment: .center)
                .overlay(Text("Ini gambar"))
            Spacer()
            Text("Throw them away now! You might get food poisoning.")
                .font(.title3)
                .fontWeight(.regular)
            Spacer()
            
            HStack {
                Image(systemName: "exclamationmark.circle.fill")
                Text("60 days old")
                    .fontWeight(.semibold)
            }
        
        }
        .padding()
        .frame(width: 120, height: 229, alignment: .center)
        .background(Color.gray)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct MainMenuCard_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuCard()
    }
}
