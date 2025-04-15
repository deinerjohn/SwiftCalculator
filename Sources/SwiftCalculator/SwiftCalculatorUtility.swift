//
//  SwiftCalculatorUtility.swift
//  SwiftCalculator
//
//  Created by Deiner John Calbang on 4/15/25.
//

import Foundation

/// A utility class that implements the core logic for a Swift-based calculator.
///
/// This class handles user input, calculator state, and communicates updates through the control processor.
/// It conforms to the `SwiftCalculator` protocol and is typically not used directly, but via the `SwiftCalculator.instance()` factory method.
open class SwiftCalculatorUtility: SwiftCalculator {
    
    private let controlProcessor: ControlProcessor
    
    init(
        initialNumber: Double,
        readyToClear: Bool,
        controlProcessor: ControlProcessor
    ) {
        self.controlProcessor = controlProcessor
        
        resetToNumber(number: initialNumber, readyToClear: readyToClear)
    }
    
    
}

extension SwiftCalculatorUtility {
    
    public func press(_ button: SwiftCalculatorButton) {
        switch button {
        case .CLEAR:
            clear()
        case .DIGIT(let digit):
            enterDigit(digit)
        case .DECIMAL:
            decimal()
        case .PLUS:
            plus()
        case .MINUS:
            substract()
        case .MULTIPLY:
            multiply()
        case .DIVIDE:
            divide()
        case .BACKSPACE:
            backSpace()
        case .PERCENT:
            percent()
        case .EQUALS:
            equals()
        }
    }
    
    private func clear() {
        controlProcessor.clearProcessor.onClear()
        controlProcessor.outputManager.update(.CLEAR)
    }
    
    public func resetToNumber(number: Double, readyToClear: Bool) {
        controlProcessor.clearProcessor.initialize(number, readyToClear)
        controlProcessor.outputManager.initialize(number)
    }
    
    private func enterDigit(_ digit: Int) {
        try? controlProcessor.numberProcessor.processNumber(.DIGIT(digit))
        controlProcessor.outputManager.update(.DIGIT(digit))
    }
    
    private func decimal() {
        try? controlProcessor.decimalProcessor.processDecimal()
        controlProcessor.outputManager.update(.DECIMAL)
    }
    
    private func plus() {
        try? controlProcessor.operatorProcessor.processOperator(.PLUS)
        controlProcessor.outputManager.update(.PLUS)
    }
    
    private func substract() {
        try? controlProcessor.operatorProcessor.processOperator(.MINUS)
        controlProcessor.outputManager.update(.MINUS)
    }
    
    private func multiply() {
        try? controlProcessor.operatorProcessor.processOperator(.MULTIPLY)
        controlProcessor.outputManager.update(.MULTIPLY)
    }
    
    private func divide() {
        try? controlProcessor.operatorProcessor.processOperator(.DIVIDE)
        controlProcessor.outputManager.update(.DIVIDE)
    }
    
    private func percent() {
        try? controlProcessor.percentProcessor.processPercent()
        controlProcessor.outputManager.update(.PERCENT)
    }
    
    private func backSpace() {
        try? controlProcessor.backspaceProcessor.onBackSpace()
        controlProcessor.outputManager.update(.BACKSPACE)
    }
    
    private func equals() {
        try? controlProcessor.operatorProcessor.processOperator(.EQUALS)
        controlProcessor.outputManager.update(.EQUALS)
    }
    
    public func setDelegate(delegate: SwiftCalculatorDelegate) {
        controlProcessor.setDelegate(delegate)
    }
    
    public func getCurrentResult() -> Decimal {
        return controlProcessor.outputManager.getCurrentResult()
    }
    
    public func getCurrentFormattedResult() -> String {
        return controlProcessor.outputManager.getCurrentFormattedResult()
    }
}
