//
//  DecimalProcessor.swift
//  SwiftCalculator
//
//  Created by Deiner John Calbang on 4/15/25.
//

import Foundation

internal class DecimalProcessor {
    private let entriesManager: EntriesManager
    private let outputManager: OutputManager
    
    init(
        entriesManager: EntriesManager,
        outputManager: OutputManager
    ) {
        self.entriesManager = entriesManager
        self.outputManager = outputManager
    }
    
    func processDecimal() throws {
        
        if entriesManager.isEntriesEmpty {
            
            entriesManager.setReadyToClear(true)
            entriesManager.addEntry(SwiftCalculatorButton.DECIMAL.rawValue)
            
        } else {
            
            switch true {
            case entriesManager.isReadyToClear:
                entriesManager.setReadyToClear(false)
                entriesManager.clearEntries()
                entriesManager.addEntry(SwiftCalculatorButton.DECIMAL.rawValue)
            case entriesManager.isLastEntryAnOperator:
                entriesManager.addEntry(SwiftCalculatorButton.DECIMAL.rawValue)
            case entriesManager.isLastEntryANumberWithDecimal:
                let entries = entriesManager.getEntries
                outputManager.updateDelegate(.error(.invalidKey(invalidType: .INVALID_DECIMAL_ENTRY, entries: entries)))
                return
            case entriesManager.isLastEntryAPercentNumber:
                let entry = entriesManager.lastEntry.trimLast()
                entriesManager.setLastEntry(entry)
                entriesManager.appendToLastEntry(SwiftCalculatorButton.DECIMAL.rawValue)
            case entriesManager.isLastEntryANumber:
                entriesManager.appendToLastEntry(SwiftCalculatorButton.DECIMAL.rawValue)
            case entriesManager.isLastEntryADecimal:
                return
            default:
                throw MathError.illegalOperation("Invalid decimal command")
            }
            
        }
        
    }
    
}
