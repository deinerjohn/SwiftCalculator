//
//  SwiftCalculatorUtility.swift
//  SwiftCalculator
//
//  Created by Deiner John Calbang on 4/15/25.
//

import Foundation

open class SwiftCalculatorUtility {
    
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

extension SwiftCalculatorUtility: SwiftCalculator {
    
    public func press(_ button: SwiftCalculatorButton) {
        switch button {
        case .CLEAR:
            clear()
        case .ONE:
            one()
        case .TWO:
            two()
        case .THREE:
            three()
        case .FOUR:
            four()
        case .FIVE:
            five()
        case .SIX:
            six()
        case .SEVEN:
            seven()
        case .EIGHT:
            eight()
        case .NINE:
            nine()
        case .ZERO:
            zero()
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
    
    private func one() {
        try? controlProcessor.numberProcessor.processNumber(.ONE)
        controlProcessor.outputManager.update(.ONE)
    }
    
    private func two() {
        try? controlProcessor.numberProcessor.processNumber(.TWO)
        controlProcessor.outputManager.update(.TWO)
    }
    
    private func three() {
        try? controlProcessor.numberProcessor.processNumber(.THREE)
        controlProcessor.outputManager.update(.THREE)
    }
    
    private func four() {
        try? controlProcessor.numberProcessor.processNumber(.FOUR)
        controlProcessor.outputManager.update(.FOUR)
    }
    
    private func five() {
        try? controlProcessor.numberProcessor.processNumber(.FIVE)
        controlProcessor.outputManager.update(.FIVE)
    }
    
    private func six() {
        try? controlProcessor.numberProcessor.processNumber(.SIX)
        controlProcessor.outputManager.update(.SIX)
    }
    
    private func seven() {
        try? controlProcessor.numberProcessor.processNumber(.SEVEN)
        controlProcessor.outputManager.update(.SEVEN)
    }
    
    private func eight() {
        try? controlProcessor.numberProcessor.processNumber(.EIGHT)
        controlProcessor.outputManager.update(.EIGHT)
    }
    
    private func nine() {
        try? controlProcessor.numberProcessor.processNumber(.NINE)
        controlProcessor.outputManager.update(.NINE)
    }
    
    private func zero() {
        try? controlProcessor.numberProcessor.processNumber(.ZERO)
        controlProcessor.outputManager.update(.ZERO)
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
    
    public func getCurrentNumber() -> Decimal {
        return controlProcessor.outputManager.getCurrentNumber()
    }
    
    
}
