// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public protocol SwiftCalculatorDelegate: AnyObject {
    func onUpdateCalculator(update: SwiftCalculatorUpdate)
}

public protocol SwiftCalculator {
    
    func press(_ button: SwiftCalculatorButton)
    func resetToNumber(number: Double, readyToClear: Bool)
    func setDelegate(delegate: SwiftCalculatorDelegate)
    func getCurrentNumber() -> Decimal
    
}

public extension SwiftCalculator {
    
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
