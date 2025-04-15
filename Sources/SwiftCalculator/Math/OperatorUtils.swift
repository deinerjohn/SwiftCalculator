//
//  OperatorUtils.swift
//  SwiftCalculator
//
//  Created by Deiner John Calbang on 4/15/25.
//

import Foundation

enum OperatorError: Error {
    case invalidOperator(String)
}

struct OperatorUtils {
    private static let operators = [
        SwiftCalculatorButton.PLUS,
        SwiftCalculatorButton.MINUS,
        SwiftCalculatorButton.DIVIDE,
        SwiftCalculatorButton.MULTIPLY,
        SwiftCalculatorButton.EQUALS
    ]
    
    static let operatorTags: [String] = operators.map { $0.rawValue }
    
    static internal func getOperator(entry: String) throws -> SwiftCalculatorButton {
        switch entry {
        case SwiftCalculatorButton.PLUS.rawValue:
            return .PLUS
        case SwiftCalculatorButton.MINUS.rawValue:
            return .MINUS
        case SwiftCalculatorButton.DIVIDE.rawValue:
            return .DIVIDE
        case SwiftCalculatorButton.MULTIPLY.rawValue:
            return .MULTIPLY
        case SwiftCalculatorButton.EQUALS.rawValue:
            return .EQUALS
        default:
            throw OperatorError.invalidOperator("Invalid operator entry: \(entry)")
        }
    }
    
    static func getOperators(_ list: Array<String>) -> Array<String> {
        return list.filter { operatorTags.contains($0) }
    }

    static func isOperator(_ entry: String) -> Bool {
        return operatorTags.contains(entry)
    }

    static func isNumber(_ entry: String) -> Bool {
        return Double(entry) != nil
    }
    
}
