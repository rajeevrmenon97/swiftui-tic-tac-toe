//
//  GridSquare.swift
//  tictactoe
//
//  Created by Rajeev R Menon on 10/5/23.
//

import SwiftUI

// Single square in a grid
struct GridSquare: View {
    let size: CGFloat
    let xIndex: Int
    let yIndex: Int
    
    @Binding var currentState: GridState
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("SecondaryColor"))
                .frame(width: size, height: size)
            if currentState == .circle {
                Image(systemName: "circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color("PrimaryColor"))
                    .frame(width: size * 0.5)
            } else if currentState == .cross {
                Image(systemName: "multiply")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color("PrimaryColor"))
                    .frame(width: size * 0.5)
            }
            
        }
    }
}
