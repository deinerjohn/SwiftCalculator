//
//  SwiftCalculatorInvalidKeyType.swift
//  SwiftCalculator
//
//  Created by Deiner John Calbang on 4/15/25.
//

/// Represents the types of invalid key entries in the calculator.
///
/// This enum is used to indicate what kind of invalid input a user attempted,
/// which can help with validation or user feedback.
public enum SwiftCalculatorInvalidKeyType {
    case INVALID_DECIMAL_ENTRY
    case INVALID_OPERATOR_ENTRY
    case INVALID_PERCENT_ENTRY
}
