//
//  StepperGrocery.swift
//  CeMeal
//
//  Created by Rafik Lutfi on 22/08/22.
//

import SwiftUI

struct StepperGrocery: View {
    var onDecrease: () -> Void
    var onIncrease: () -> Void
    
    var body: some View {
        ZStack {
            Color.lightGray
                .ignoresSafeArea()
            
            HStack {
                Spacer()
                Image(systemName: "minus.circle.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color.lightGreen)
                    .onTapGesture {
                        onDecrease()
                    }
                Divider()
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color.lightGreen)
                    .onTapGesture {
                        onIncrease()
                    }
                Spacer()
            }
        }
        .frame(width: 69, height: 34)
        .cornerRadius(17)
        .shadow(radius: 2)
    }
}

struct StepperGrocery_Previews: PreviewProvider {
    static var previews: some View {
        StepperGrocery {
            
        } onIncrease: {
            
        }
        
    }
}
