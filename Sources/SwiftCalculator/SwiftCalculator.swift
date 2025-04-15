// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public protocol SwiftCalculatorDelegate: AnyObject {
    func onUpdateCalculator(update: SwiftCalculatorUpdate)
}

public protocol SwiftCalculator {
    
    /// Simulates pressing a calculator button.
    ///
    /// This will handle the logic for different button types like:
    /// - **Operators**: `+`, `-`, `*`, `/`
    /// - **Numbers**: `0` to `9`
    /// - *Other symbols*: `.` (decimal), `%` (percent)
    ///
    /// - Parameter button: The `SwiftCalculatorButton` being pressed.
    func press(_ button: SwiftCalculatorButton)
    
    /// Resets the calculator with a specific starting number.
    ///
    /// Useful for setting a starting value or preloading a result, such as after a programmatic calculation.
    ///
    /// - Parameters:
    ///   - number: The number to set as the current value.
    ///   - readyToClear: Indicates whether the calculator should clear on display.
    func resetToNumber(number: Double, readyToClear: Bool)
    
    /// Sets the delegate that will receive calculator updates.
    ///
    /// Use this to get notified when the calculator updates, such as after a button press or result change.
    ///
    /// - Parameter delegate: An object conforming to `SwiftCalculatorDelegate`.
    func setDelegate(delegate: SwiftCalculatorDelegate)
    
    /// Returns the current unformatted calculation result.
    ///
    /// This is the raw numerical value used internally by the calculator.
    ///
    /// - Returns: A `Decimal` representing the current result.
    func getCurrentResult() -> Decimal
    
    /// Returns the current result as a user-friendly formatted string.
    ///
    /// This is typically used for display in the UI (e.g., with commas).
    ///
    /// - Returns: A formatted `String` representing the current result.
    func getCurrentFormattedResult() -> String
    
}

public extension SwiftCalculator {
    
    /// Creates a new calculator instance with optional configuration.
    /// - Parameters:
    ///   - calculatorType: The type of calculator to create (e.g., Mdas, nonMdas).
    ///   - initialNumber: The initial number shown on the calculator.
    ///   - readyToClear: Whether the calculator should clear the display.
    ///   - delegate: A delegate to receive updates from the calculator.
    /// - Returns: An instance of a calculator conforming to `SwiftCalculator`.
    static func instance(
        calculatorType: SwiftCalculatorType = .BASIC_MDAS,
        initialNumber: Double = 0.0,
        readyToClear: Bool = true,
        delegate: SwiftCalculatorDelegate? = nil
    ) -> SwiftCalculator {
        return SwiftCalculatorUtility(
            initialNumber: initialNumber,
            readyToClear: readyToClear,
            controlProcessor: ControlProcessor.instance(
                entriesManager: EntriesManager.instance(),
                calculatorType: calculatorType,
                delegate: delegate
            )
        )
    }
    
}
