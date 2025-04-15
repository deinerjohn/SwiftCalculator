//
//  BackspaceProcessor.swift
//  SwiftCalculator
//
//  Created by Deiner John Calbang on 4/15/25.
//

import Foundation

enum BackspaceProcessorError: Error {
    case invalid(String)
}

internal class BackspaceProcessor {
    private let entriesManager: EntriesManager
    
    init(entriesManager: EntriesManager) {
        self.entriesManager = entriesManager
    }
    
    func onBackSpace() throws {
        
        if entriesManager.hasEntries {
            
            let entry = entriesManager.lastEntry.trimLast()
            
            switch true {
            case entriesManager.isReadyToClear:
                entriesManager.setReadyToClear(true)
                
                if !entry.isEmpty {
                    entriesManager.setLastEntry(entry)
                } else {
                    entriesManager.removeLastEntry()
                }
            case entriesManager.isLastEntryAPercentNumber:
                entriesManager.setLastEntry(entry)
            case entriesManager.isLastEntryANumber:
                if !entry.isEmpty {
                    entriesManager.setLastEntry(entry)
                } else {
                    entriesManager.removeLastEntry()
                }
            case entriesManager.isLastEntryEndsWithExponent:
                entriesManager.setLastEntry(entry)
            case entriesManager.isLastEntryAnOperator, entriesManager.isLastEntryADecimal:
                entriesManager.removeLastEntry()
            default:
                throw BackspaceProcessorError.invalid("Invalid backspace")
            }
            
        }
    }
    
}
