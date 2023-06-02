//
//  ContentView.swift
//  ReinforcementLearningPlayground
//
//  Created by Yuriy Nefedov on 01.06.2023.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple]
    
    @StateObject var viewModel = GameViewModel()
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(0..<Constants.gridSize.y, id: \.self) { y in
                    HStack(alignment: .center, spacing: 0) {
                        ForEach(0..<Constants.gridSize.x, id: \.self) { x in
                            pixel(at: .init(x: x, y: y))
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder func pixel(at vector: IntegerVector) -> some View {
        let color: Color = {
            if viewModel.playerPosition == vector {
                return Constants.playerColor
            } else if viewModel.foodPosition == vector {
                return Constants.foodColor
            } else {
                return Constants.backgroundColor
            }
        }()
        Rectangle()
            .frame(width: Constants.pixelSize, height: Constants.pixelSize)
            .foregroundColor(color)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
