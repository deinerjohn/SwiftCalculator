//
//  EntriesManager.swift
//  SwiftCalculator
//
//  Created by Deiner John Calbang on 4/15/25.
//

import Foundation

internal class EntriesManager {
    private var entries: Array<String> = []
    private var result: Decimal? = nil
    private var readyToClear: Bool = false
    
    static func instance() -> EntriesManager {
        return EntriesManager()
    }
    
    func getEntries() -> Array<String> {
        return entries
    }

    func clearEntries() {
        entries.removeAll()
    }

    func isReadyToClear() -> Bool {
        return readyToClear
    }

    func setReadyToClear(_ readyToClear: Bool) {
        self.readyToClear = readyToClear
    }

    func getResult() -> Decimal {
        return result ?? 0.0
    }

    func setResult(_ result: Decimal) {
        self.result = result
    }

    func addEntry(_ entry: String) {
        entries.append(entry)
    }

    func isEntriesEmpty() -> Bool {
        return entries.isEmpty
    }

    func hasEntries() -> Bool {
        return !entries.isEmpty
    }

    func isSingleEntry() -> Bool {
        return entries.count == 1
    }

    func removeLastEntry() {
        if self.hasEntries() {
            entries.removeLast()
        }
    }

    func setLastEntry(_ entry: String) {
        if let lastIndex = entries.indices.last {
            entries[lastIndex] = entry
        }
    }

    func appendToLastEntry(_ text: String) {
        setLastEntry(getLastEntry() + text)
    }

    func getLastEntry() -> String {
        return entries.last ?? ""
    }

    func getLastDoubleEntry() -> Decimal {
        let lastEntry = getLastEntry()

        var value: Double = 0.0
        
        if lastEntry.hasSuffix(SwiftCalculatorButton.PERCENT.rawValue) {
            let trimmedEntry = lastEntry.dropLast()
            value = (Double(trimmedEntry) ?? 0.0) / 100.0
        } else if lastEntry.lowercased().hasSuffix("e") {
            let trimmedEntry = lastEntry.dropLast()
            value = Double(trimmedEntry) ?? 0.0
        } else if lastEntry.lowercased().hasSuffix("e-") {
            let trimmedEntry = lastEntry.dropLast(2)
            value = Double(trimmedEntry) ?? 0.0
        } else {
            value = Double(lastEntry) ?? 0.0
        }
        
        return Decimal(value)
    }

    func isLastEntryADecimal() -> Bool {
        return getLastEntry().lowercased() == SwiftCalculatorButton.DECIMAL.rawValue.lowercased()
    }

    func isLastEntryAnOperator() -> Bool {
        return OperatorUtils.operatorTags.contains(getLastEntry())
    }

    func isLastEntryAPercentNumber() -> Bool {
        return getLastEntry().hasSuffix(SwiftCalculatorButton.PERCENT.rawValue)
    }

    func isLastEntryEndsWithExponent() -> Bool {
        let entry = getLastEntry().lowercased()
        return entry.hasSuffix("e") || entry.hasSuffix("e-")
    }

    func isLastEntryANumber() -> Bool {
        return Double(getLastEntry()) != nil
    }

    func isLastEntryANumberWithDecimal() -> Bool {

        if (isLastEntryANumber() || isLastEntryAPercentNumber()) {
            return getLastEntry().contains(SwiftCalculatorButton.DECIMAL.rawValue)
        } else {
            return false
        }
    }

    func isLastEntryEndsWithDecimal() -> Bool {
        return getLastEntry().hasSuffix(SwiftCalculatorButton.DECIMAL.rawValue)
    }
    
}
