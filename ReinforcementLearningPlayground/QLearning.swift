//
//  QLearning.swift
//  SpriteKit-Playground
//
//  Created by Yuriy Nefedov on 01.06.2023.
//

import Foundation

class QLearning {
    var qValues: [String: Double] // The Q-table is now a dictionary
    let learningRate: Double
    let discountFactor: Double
    let actions: [Move] // Available actions

    init(actions: [Move], learningRate: Double, discountFactor: Double) {
        self.actions = actions
        self.learningRate = learningRate
        self.discountFactor = discountFactor
        self.qValues = [:] // Initialize an empty dictionary
    }

    func stateActionKey(state: IntegerVector, action: Move) -> String {
        return "\(state.x),\(state.y):\(action.rawValue)"
    }

    func chooseAction(state: IntegerVector, epsilon: Double) -> Move {
        let randomValue = Double.random(in: 0...1)
        if randomValue < epsilon {
            return actions.randomElement()! // Explore: select a random action
        } else {
            return bestAction(state: state) // Exploit: select the action with the highest q-value for this state
        }
    }

    func bestAction(state: IntegerVector) -> Move {
        var maxQValue = -Double.infinity
        var bestAction = actions[0]
        for action in actions {
            let key = stateActionKey(state: state, action: action)
            let qValue = qValues[key, default: 0.0]
            if qValue > maxQValue {
                maxQValue = qValue
                bestAction = action
            }
        }
        return bestAction
    }

    func updateQValue(previousState: IntegerVector, action: Move, reward: Double, currentState: IntegerVector) {
        let oldQValueKey = stateActionKey(state: previousState, action: action)
        let oldQValue = qValues[oldQValueKey, default: 0.0]

        let maxFutureQValue = actions.map { qValues[stateActionKey(state: currentState, action: $0), default: 0.0] }.max()!

        let newQValue = (1 - learningRate) * oldQValue + learningRate * (reward + discountFactor * maxFutureQValue)

        qValues[oldQValueKey] = newQValue
    }
}
