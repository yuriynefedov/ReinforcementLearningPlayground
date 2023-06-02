//
//  GameViewModel.swift
//  ReinforcementLearningPlayground
//
//  Created by Yuriy Nefedov on 01.06.2023.
//

import Foundation

class GameViewModel: ObservableObject {
    @Published var playerPosition: IntegerVector = .random(boundedBy: Constants.gridSize)
    @Published var foodPosition: IntegerVector = .random(boundedBy: Constants.gridSize)
    private var qLearning = QLearning(actions: Move.allCases, learningRate: 0.5, discountFactor: 0.95)
    
    init() {
        start()
    }
    
    func start() {
        Timer.scheduledTimer(withTimeInterval: 1/Double(Constants.movesPerSecond), repeats: true) { _ in
            self.step()
            self.objectWillChange.send()
        }
    }
    
    func step() {
        let bestMove = qLearning.chooseAction(state: playerPosition - foodPosition, epsilon: 0.05)
        execute(bestMove)
    }
    
    func canExecute(_ move: Move) -> Bool {
        let newVector = playerPosition + move.vector()
        return newVector.isBoundedBy(other: Constants.gridSize)
    }
    
    func execute(_ move: Move, respawnIfImpossible: Bool = true) {
        if canExecute(move) {
            let oldVector = (playerPosition - foodPosition)
            self.playerPosition = self.playerPosition + move.vector()
            let newVector = (playerPosition - foodPosition)
            self.learn(move: move, oldVector: oldVector, newVector: newVector)
        } else if respawnIfImpossible {
            playerPosition = .random(boundedBy: Constants.gridSize)
        }
        if playerPosition == foodPosition {
            foodPosition = .random(boundedBy: Constants.gridSize)
        }
    }
    
    func learn(move: Move, oldVector: IntegerVector, newVector: IntegerVector) {
        // Define the reward based on the change in distance
        let reward: Double
        if newVector.length < oldVector.length {
            reward = 100.0 // Reward for moving closer to food
        } else if newVector.length > oldVector.length {
            reward = -100.0 // Penalty for moving away from food
        } else {
            reward = 0.0 // No change in distance
        }

        qLearning.updateQValue(previousState: oldVector, action: move, reward: reward, currentState: newVector)
    }
}
