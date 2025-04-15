//
//  SwiftCalculatorUpdate.swift
//  SwiftCalculator
//
//  Created by Deiner John Calbang on 4/15/25.
//

import Foundation

public enum SwiftCalculatorUpdate {
    case initializing(number: Double, entries: Array<String>)
    case updating(
        key: String?,
        entries: Array<String>,
        result: Decimal,
        resultString: String
    )
    case error(SwiftCalculatorError)
}

public enum SwiftCalculatorError {
    case divideByZero(key: String, entries: Array<String>)
    case invalidKey(invalidType: SwiftCalculatorInvalidKeyType, entries: Array<String>)
}
