//
//  StepperGrocery.swift
//  CeMeal
//
//  Created by Rafik Lutfi on 22/08/22.
//

import SwiftUI

struct StepperGrocery: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.gray],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            HStack {
                Image(systemName: "minus.circle.fill")
                    .foregroundColor(.mint)
                    .font(.system(size: 30, weight: .heavy))
                
                Divider()
                
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.mint)
                    .font(.system(size: 30, weight: .heavy))
            }
        }
        .frame(width: 100, height: 50)
        .cornerRadius(90)
    }
}

struct StepperGrocery_Previews: PreviewProvider {
    static var previews: some View {
        StepperGrocery()
    }
}
