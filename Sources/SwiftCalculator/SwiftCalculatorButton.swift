//
//  SwiftCalculatorButton.swift
//  SwiftCalculator
//
//  Created by Deiner John Calbang on 4/15/25.
//

import Foundation

public enum SwiftCalculatorButton: Equatable {
    case CLEAR
    case DIGIT(Int)
    case DECIMAL
    case PLUS
    case MINUS
    case MULTIPLY
    case DIVIDE
    case BACKSPACE
    case PERCENT
    case EQUALS
    
    public var rawValue: String {
        switch self {
        case .CLEAR:
            return "clear"
        case .DIGIT(let number):
            return String(number)
        case .DECIMAL:
            return "."
        case .PLUS:
            return "+"
        case .MINUS:
            return "-"
        case .MULTIPLY:
            return "*"
        case .DIVIDE:
            return "/"
        case .BACKSPACE:
            return "backspace"
        case .PERCENT:
            return "%"
        case .EQUALS:
            return "="
        }
    }
    
}
