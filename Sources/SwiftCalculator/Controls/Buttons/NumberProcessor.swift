//
//  NumberProcessor.swift
//  SwiftCalculator
//
//  Created by Deiner John Calbang on 4/15/25.
//

import Foundation

internal class NumberProcessor {
    private let entriesManager: EntriesManager
    
    init(entriesManager: EntriesManager) {
        self.entriesManager = entriesManager
    }
    
    func processNumber(_ calculatorButton: SwiftCalculatorButton) throws {
        let number = calculatorButton.rawValue
        
        switch true {
        case entriesManager.isEntriesEmpty:
            
            entriesManager.setReadyToClear(false)
            entriesManager.addEntry(number)
            
        case entriesManager.isReadyToClear:
            
            entriesManager.setReadyToClear(false)
            entriesManager.clearEntries()
            entriesManager.addEntry(number)
            
        case entriesManager.isLastEntryAnOperator:
            entriesManager.addEntry(number)
            
        case entriesManager.isLastEntryAPercentNumber:
            
            let entry = entriesManager.lastEntry.trimLast()
            entriesManager.setLastEntry(entry)
            entriesManager.appendToLastEntry(number)
            
        case entriesManager.isLastEntryANumber:
            
            if (entriesManager.lastEntry == "0") {
                entriesManager.setLastEntry(number)
            } else {
                entriesManager.appendToLastEntry(number)
            }
            
        case entriesManager.isLastEntryADecimal:
            entriesManager.appendToLastEntry(number)
            
        default:
            throw MathError.illegalOperation("Invalid number command")
        }
        
    }
}
