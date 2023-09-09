//
//  ContentView.swift
//  tictactoe
//
//  Created by Rajeev R Menon on 9/9/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            GeometryReader{ geometry in
                VStack {
                    ForEach(0..<3) { i in
                        HStack {
                            ForEach(0..<3) { j in
                                GridSquare(size: geometry.size.width * 0.3, xIndex: i, yIndex: j)
                            }
                        }
                        .frame(width: geometry.size.width)
                    }
                }
                .frame(height: geometry.size.height)
            }
        }.padding()
        
    }
}

struct GridSquare: View {
    let size: CGFloat
    let xIndex: Int
    let yIndex: Int
    
    var body: some View {
        Rectangle()
            .fill(.gray)
            .frame(width: size, height: size)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
