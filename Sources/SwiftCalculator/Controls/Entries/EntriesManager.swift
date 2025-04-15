//
//  EntriesManager.swift
//  SwiftCalculator
//
//  Created by Deiner John Calbang on 4/15/25.
//

import Foundation

internal class EntriesManager {
    
    //MARK: - Properties
    
    private(set) var entries: Array<String> = []
    private(set) var result: Decimal? = nil
    private(set) var readyToClear: Bool = false
    private(set) var formattedResult: String? = nil
    
    //MARK: - Instance
    static func instance() -> EntriesManager {
        return EntriesManager()
    }
    
    //MARK: - Setters
    
    func clearEntries() {
        entries.removeAll()
    }
    
    func removeLastEntry() {
        if hasEntries {
            entries.removeLast()
        }
    }
    
    func setLastEntry(_ entry: String) {
        if let lastIndex = entries.indices.last {
            entries[lastIndex] = entry
        }
    }
    
    func appendToLastEntry(_ text: String) {
        setLastEntry(lastEntry + text)
    }
    
    func setFormattedResult(_ formattedResult: String) {
        self.formattedResult = formattedResult
    }

    func addEntry(_ entry: String) {
        entries.append(entry)
    }
    
    func setReadyToClear(_ readyToClear: Bool) {
        self.readyToClear = readyToClear
    }
    
    func setResult(_ result: Decimal) {
        self.result = result
    }
    
    //MARK: - Getters / Boolean Checkers
    
    var lastEntry: String {
        return entries.last ?? ""
    }
    
    var getEntries: Array<String> {
        return entries
    }

    var isReadyToClear: Bool {
        return readyToClear
    }

    var getResult: Decimal {
        return result ?? 0.0
    }
    
    var getFormattedResult: String {
        return formattedResult ?? ""
    }
    
    var isEntriesEmpty: Bool {
        return entries.isEmpty
    }

    var hasEntries: Bool {
        return !entries.isEmpty
    }

    var isSingleEntry: Bool {
        return entries.count == 1
    }

    var getLastDoubleEntry: Decimal {
        var value: Double = 0.0
        
        if lastEntry.hasSuffix(SwiftCalculatorButton.PERCENT.rawValue) {
            let trimmedEntry = lastEntry.trimLast()
            value = (Double(trimmedEntry) ?? 0.0) / 100.0
        } else if lastEntry.lowercased().hasSuffix("e") {
            let trimmedEntry = lastEntry.trimLast()
            value = Double(trimmedEntry) ?? 0.0
        } else if lastEntry.lowercased().hasSuffix("e-") {
            let trimmedEntry = lastEntry.dropLast(2)
            value = Double(trimmedEntry) ?? 0.0
        } else {
            value = Double(lastEntry) ?? 0.0
        }
        
        return Decimal(value)
    }

    var isLastEntryADecimal: Bool {
        return lastEntry.lowercased() == SwiftCalculatorButton.DECIMAL.rawValue.lowercased()
    }

    var isLastEntryAnOperator: Bool {
        return OperatorUtils.operatorTags.contains(lastEntry)
    }

    var isLastEntryAPercentNumber: Bool {
        return lastEntry.hasSuffix(SwiftCalculatorButton.PERCENT.rawValue)
    }

    var isLastEntryEndsWithExponent: Bool {
        let entry = lastEntry.lowercased()
        return entry.hasSuffix("e") || entry.hasSuffix("e-")
    }

    var isLastEntryANumber: Bool {
        return Double(lastEntry) != nil
    }

    var isLastEntryANumberWithDecimal: Bool {

        if (isLastEntryANumber || isLastEntryAPercentNumber) {
            return lastEntry.contains(SwiftCalculatorButton.DECIMAL.rawValue)
        } else {
            return false
        }
    }

    var isLastEntryEndsWithDecimal: Bool {
        return lastEntry.hasSuffix(SwiftCalculatorButton.DECIMAL.rawValue)
    }
    
}
