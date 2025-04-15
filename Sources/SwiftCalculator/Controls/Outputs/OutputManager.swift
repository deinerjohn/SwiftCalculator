//
//  OutputManager.swift
//  SwiftCalculator
//
//  Created by Deiner John Calbang on 4/15/25.
//

import Foundation

internal class OutputManager {
    
    weak var delegate: SwiftCalculatorDelegate?
    
    private let entriesManager: EntriesManager
    private let equationSolver: EquationSolver
    
    init(
        delegate: SwiftCalculatorDelegate? = nil,
        entriesManager: EntriesManager,
        equationSolver: EquationSolver
    ) {
        self.delegate = delegate
        self.entriesManager = entriesManager
        self.equationSolver = equationSolver
    }
    
    static func instance(
        entriesManager: EntriesManager,
        calculatorType: SwiftCalculatorType,
        delegate: SwiftCalculatorDelegate?
    ) -> OutputManager {
        let equationSolver = EquationSolver.instance(calculatorType)
        return OutputManager(
            delegate: delegate,
            entriesManager: entriesManager,
            equationSolver: equationSolver
        )
    }
    
}

extension OutputManager {
    func update(_ button: SwiftCalculatorButton) {
        let entries = entriesManager.getEntries()
        
        do {
            
            var result: Decimal = .zero

            switch true {
            case entriesManager.isEntriesEmpty():
                result = .zero
                
            case entriesManager.isSingleEntry():
                switch true {
                case entriesManager.isLastEntryADecimal():
                    result = .zero
                    
                case entriesManager.isLastEntryAPercentNumber(),
                    entriesManager.isLastEntryANumber(),
                    entriesManager.isLastEntryEndsWithExponent():
                    
                    result = entriesManager.getLastDoubleEntry()
                    
                default:
                    throw MathError.illegalOperation("Invalid entry: \(entriesManager.getLastEntry())")
                }
                
            default:
                result = try equationSolver.solve(entries: entries)
            }

            entriesManager.setResult(result)

            if (button == SwiftCalculatorButton.EQUALS) {
                entriesManager.setReadyToClear(true)
            }

            let resultText: String = {
                if entries.count >= 1 && entries.count <= 2 {
                    return String(describing: entries.first!)
                } else {
                    return NSDecimalNumber(decimal: result).stringValue
                }
            }()

            print("Calculator: Key: \(button.rawValue) | Entries: \(entries) | Raw result: \(result) " +
                  "| Formatted Result String: \(resultText.formattedWithCommas())")

            updateDelegate(
                SwiftCalculatorUpdate.updating(
                    key: button.rawValue,
                    entries: entries,
                    result: result,
                    formattedResult: resultText.formattedWithCommas()
                )
            )
        } catch {
            print("Calculator: Divide by zero error")
            
            delegate?.onUpdateCalculator(
                update: .error(
                .divideByZero(
                    key: button.rawValue,
                    entries: entries
                ))
            )

            if (button == SwiftCalculatorButton.EQUALS) {
                entriesManager.removeLastEntry()
            }
        }
    }

    func initialize(_ number: Double) {
        let entries = entriesManager.getEntries()
        updateDelegate(SwiftCalculatorUpdate.initializing(number: number, entries: entries))
        print("Calculator: Initializing calculator \(number) | Entries: \(entries)")
    }

    func updateDelegate(_ calculatorUpdate: SwiftCalculatorUpdate) {
        delegate?.onUpdateCalculator(update: calculatorUpdate)
    }

    func getCurrentNumber() -> Decimal {
        return entriesManager.getResult()
    }
}
