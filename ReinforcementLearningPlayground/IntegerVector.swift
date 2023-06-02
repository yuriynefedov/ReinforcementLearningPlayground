//
//  IntegerVector.swift
//  ReinforcementLearningPlayground
//
//  Created by Yuriy Nefedov on 02.06.2023.
//

import Foundation

struct IntegerVector: Equatable {
    let x: Int
    let y: Int
    
    static func random(boundedBy bounds: IntegerVector) -> IntegerVector {
        .init(
            x: (0..<bounds.x).randomElement()!,
            y: (0..<bounds.y).randomElement()!
        )
    }
    
    static func +(lhs: IntegerVector, rhs: IntegerVector) -> IntegerVector {
        .init(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    static func -(lhs: IntegerVector, rhs: IntegerVector) -> IntegerVector {
        .init(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    func isBoundedBy(other: IntegerVector) -> Bool {
        return self.x >= 0 && self.y >= 0 && self.x < other.x && self.y < other.y
    }
    
    var length: Double {
        return sqrt(pow(Double(self.x), 2) + pow(Double(self.y), 2))
    }
}
