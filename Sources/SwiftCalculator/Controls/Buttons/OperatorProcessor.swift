//
//  OperatorProcessor.swift
//  SwiftCalculator
//
//  Created by Deiner John Calbang on 4/15/25.
//

import Foundation

internal class OperatorProcessor {
    private let entriesManager: EntriesManager
    private let outputManager: OutputManager
    
    init(
        entriesManager: EntriesManager,
        outputManager: OutputManager
    ) {
        self.entriesManager = entriesManager
        self.outputManager = outputManager
    }
    
    func processOperator(_ calculatorButton: SwiftCalculatorButton) throws {
        let `operator` = calculatorButton.rawValue
        
        switch true {
        case entriesManager.isEntriesEmpty():
            
            entriesManager.setReadyToClear(false)
            entriesManager.addEntry(SwiftCalculatorButton.ZERO.rawValue)
            entriesManager.addEntry(`operator`)
            
        case entriesManager.isReadyToClear():
            
            entriesManager.setReadyToClear(false)
            entriesManager.clearEntries()
            entriesManager.addEntry(String(describing: entriesManager.getResult()))
            entriesManager.addEntry(`operator`)
            
        case entriesManager.isLastEntryAnOperator():
            
            entriesManager.removeLastEntry()
            entriesManager.addEntry(`operator`)
            
        case entriesManager.isLastEntryAPercentNumber():
            
            entriesManager.addEntry(`operator`)
            
        case entriesManager.isLastEntryANumber():
            
            if (entriesManager.isLastEntryEndsWithDecimal()) {
                entriesManager.setLastEntry(String(entriesManager.getLastEntry().dropLast()))
                entriesManager.addEntry(`operator`)
            } else {
                entriesManager.addEntry(`operator`)
            }
            
        case entriesManager.isLastEntryADecimal():
            
            if (entriesManager.isSingleEntry()) {
                entriesManager.removeLastEntry()
                entriesManager.addEntry(SwiftCalculatorButton.ZERO.rawValue)
                entriesManager.addEntry(`operator`)
            } else {
                entriesManager.removeLastEntry()
                entriesManager.removeLastEntry()
                entriesManager.addEntry(`operator`)
            }
            
        default:
            throw MathError.illegalOperation("Invalid operator entry")
        }
    }
}
