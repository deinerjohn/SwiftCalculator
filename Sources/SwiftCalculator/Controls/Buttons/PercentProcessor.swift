//
//  PercentProcessor.swift
//  SwiftCalculator
//
//  Created by Deiner John Calbang on 4/15/25.
//

internal class PercentProcessor {
    
    private let entriesManager: EntriesManager
    private let outputManager: OutputManager
    
    init(
        entriesManager: EntriesManager,
        outputManager: OutputManager
    ) {
        self.entriesManager = entriesManager
        self.outputManager = outputManager
    }
    
    func processPercent() throws {
        let entries = entriesManager.getEntries
        
        if (entriesManager.isEntriesEmpty) {
            outputManager.updateDelegate(.error(.invalidKey(invalidType: .INVALID_PERCENT_ENTRY, entries: entries)))
            return
        } else {
            switch true {
                case entriesManager.isReadyToClear,
                entriesManager.isLastEntryAnOperator,
                entriesManager.isLastEntryAPercentNumber,
                entriesManager.isLastEntryADecimal:
                
                outputManager.updateDelegate(.error(.invalidKey(invalidType: .INVALID_PERCENT_ENTRY, entries: entries)))
                return
            case entriesManager.isLastEntryANumber:
                if (entriesManager.isLastEntryEndsWithDecimal) {
                    entriesManager.setLastEntry(entriesManager.lastEntry.trimLast())
                }
                entriesManager.appendToLastEntry(SwiftCalculatorButton.PERCENT.rawValue)
            default:
                outputManager.updateDelegate(.error(.invalidKey(invalidType: .INVALID_PERCENT_ENTRY, entries: entries)))
                throw MathError.illegalOperation("Invalid operator entry")
            }
        }
        
    }
    
    
}
