//
//  ClearProcessor.swift
//  SwiftCalculator
//
//  Created by Deiner John Calbang on 4/15/25.
//

import Foundation

internal class ClearProcessor {
    private let entriesManager: EntriesManager
    
    init(entriesManager: EntriesManager) {
        self.entriesManager = entriesManager
    }
    
    func initialize(_ initialNumber: Double, _ readyToClear: Bool) {
        entriesManager.clearEntries()
        entriesManager.setReadyToClear(readyToClear)
        
        if (
            initialNumber != 0.0 &&
            !initialNumber.isInfinite &&
            !initialNumber.isNaN
        ) {
            var decimal = Decimal(initialNumber)
            var rounded = Decimal()
            NSDecimalRound(&rounded, &decimal, 0, .plain)
            
            let entry = (initialNumber.truncatingRemainder(dividingBy: 1) == 0.0) ? "\(rounded)" : "\(Decimal(initialNumber))"
            
            entriesManager.addEntry(entry)
            entriesManager.setResult(Decimal(initialNumber))
        }
    }
    
    func onClear() {
        entriesManager.clearEntries()
        entriesManager.setReadyToClear(true)
    }
}
