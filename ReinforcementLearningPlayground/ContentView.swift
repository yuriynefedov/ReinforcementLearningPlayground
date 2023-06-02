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
            Constants.backgroundColor
            foodPixel
            playerPixel
        }
        .frame(
            width: Constants.pixelSize * CGFloat(Constants.gridSize.x),
            height: Constants.pixelSize * CGFloat(Constants.gridSize.y)
        )
    }
    
    @ViewBuilder var foodPixel: some View {
        let color: Color = Constants.foodColor
        Rectangle()
            .frame(width: Constants.pixelSize, height: Constants.pixelSize)
            .foregroundColor(color)
            .position(
                x: CGFloat(viewModel.foodPosition.x) * Constants.pixelSize + Constants.pixelSize/2,
                y: CGFloat(viewModel.foodPosition.y) * Constants.pixelSize + Constants.pixelSize/2
            )
    }
    
    @ViewBuilder var playerPixel: some View {
        let color: Color = Constants.playerColor
        Rectangle()
            .frame(width: Constants.pixelSize, height: Constants.pixelSize)
            .foregroundColor(color)
            .position(
                x: CGFloat(viewModel.playerPosition.x) * Constants.pixelSize + Constants.pixelSize/2,
                y: CGFloat(viewModel.playerPosition.y) * Constants.pixelSize + Constants.pixelSize/2
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
