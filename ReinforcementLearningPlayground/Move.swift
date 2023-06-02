//
//  Move.swift
//  ReinforcementLearningPlayground
//
//  Created by Yuriy Nefedov on 01.06.2023.
//

import Foundation

enum Move: Int, CaseIterable {
    case left = 0, right, up, down
    
    static func random() -> Move {
        return allCases.randomElement()!
    }
    
    func vector() -> IntegerVector {
        switch self {
        case .left:
            return .init(x: -1, y: 0)
        case .right:
            return .init(x: +1, y: 0)
        case .up:
            return .init(x: 0, y: -1)
        case .down:
            return .init(x: 0, y: +1)
        }
    }
}
