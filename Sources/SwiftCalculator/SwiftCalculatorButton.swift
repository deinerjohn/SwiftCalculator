//
//  SwiftCalculatorButton.swift
//  SwiftCalculator
//
//  Created by Deiner John Calbang on 4/15/25.
//

import Foundation


/// Represents the types of buttons that can be used in a Swift-based calculator.
///
/// Buttons include digits, operators, and function keys such as clear or equals.
public enum SwiftCalculatorButton: Equatable {
    
    /// The clear button. Resets the calculator.
    case CLEAR
    
    /// A numeric digit from 0 to 9.
    /// - Parameter number: The digit value.
    case DIGIT(Int)
    
    /// The decimal point (".") button.
    case DECIMAL
    
    /// The addition operator ("+").
    case PLUS
    
    /// The subtraction operator ("-").
    case MINUS
    
    /// The multiplication operator ("*").
    case MULTIPLY
    
    /// The division operator ("/").
    case DIVIDE
    
    /// The backspace/delete button.
    case BACKSPACE
    
    /// The percent ("%") button.
    case PERCENT
    
    /// The equals ("=") button to evaluate the expression.
    case EQUALS
    
    /// - Returns: A `String` value representing the button.
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
