//
//  SwiftCalculatorUpdate.swift
//  SwiftCalculator
//
//  Created by Deiner John Calbang on 4/15/25.
//

import Foundation

/// Represents an update event in the calculator's state, used to notify the delegate.
public enum SwiftCalculatorUpdate {
    
    /// Called when the calculator is being initialized.
    ///
    /// - Parameters:
    ///   - number: The initial number shown on the calculator display.
    ///   - entries: The list of raw string entries (e.g., numbers and operators).
    case initializing(number: Double, entries: Array<String>)
    
    /// Called when the calculator state changes due to user interaction.
    ///
    /// - Parameters:
    ///   - key: The key that triggered the update (if applicable).
    ///   - entries: The current raw entries in the expression.
    ///   - formattedEntries: The formatted entries, suitable for display.
    ///   - result: The raw calculated result.
    ///   - formattedResult: A user-friendly version of the result (e.g., with commas).
    case updating(
        key: String?,
        entries: Array<String>,
        formattedEntries: Array<String>,
        result: Decimal,
        formattedResult: String
    )
    
    /// Called when an error occurs during calculation or input.
    ///
    /// - Parameter error: A specific `SwiftCalculatorError` describing the issue.
    case error(SwiftCalculatorError)
}

/// Represents specific errors that can occur during calculator input or evaluation.
public enum SwiftCalculatorError {
    case divideByZero(key: String, entries: Array<String>)
    case invalidKey(invalidType: SwiftCalculatorInvalidKeyType, entries: Array<String>)
}
