//
//  BasicMdasCalculator.swift
//  SwiftCalculator
//
//  Created by Deiner John Calbang on 4/15/25.
//

import Foundation

class BasicMdasCalculator: EntriesCalculator {
    
    init() { }
    
    func solve(_ entries: Array<String>) throws -> Decimal {
        var entriesToProcess = entries
        
        if let last = entriesToProcess.last, OperatorUtils.isOperator(last) {
            entriesToProcess.removeLast()
        }
        
        return try calculate(entriesToProcess)
    }
    
    
}

extension BasicMdasCalculator {
    
    private func calculate(_ entries: Array<String>) throws -> Decimal {
        var a = Decimal.zero
        var b = Decimal.zero
        
        guard entries.count != 1 else {
            return getEntryWithPercentFactor(entries[0])
        }
        
        for i in entries.indices {
            
            if (OperatorUtils.isOperator(entries[i])) {
                continue
            }
            
            if (i == 0) {
                
                switch entries[1] {
                case SwiftCalculatorButton.PLUS.rawValue, SwiftCalculatorButton.MINUS.rawValue:
                    a = getEntryWithPercentFactor(entries[0])
                case SwiftCalculatorButton.MULTIPLY.rawValue, SwiftCalculatorButton.DIVIDE.rawValue:
                    b = getEntryWithPercentFactor(entries[0])
                default:
                    throw MathError.illegalOperation("Error solving first entry")
                }
                
                continue
            }
            
            if (i == entries.count - 1) {
                
                switch entries[i - 1] {
                case SwiftCalculatorButton.PLUS.rawValue:
                    a += getEntryWithPercentFactor(entry: entries[i], baseNumber: a)
                case SwiftCalculatorButton.MINUS.rawValue:
                    a -= getEntryWithPercentFactor(entry: entries[i], baseNumber: a)
                case SwiftCalculatorButton.MULTIPLY.rawValue:
                    b *= getEntryWithPercentFactor(entries[i])
                    a += b
                case SwiftCalculatorButton.DIVIDE.rawValue:
                    var divisor = (try? getDivisor(entries: entries, i: i)) ?? .zero
                    
                    var roundedResult = Decimal()
                    NSDecimalRound(&roundedResult, &divisor, 10, .plain)
                    
                    b /= roundedResult
                    a += b
                default:
                    throw MathError.illegalOperation("Error solving first entry")
                }
                
                return a
            }
            
            
            switch entries[i + 1] {
                
            case SwiftCalculatorButton.PLUS.rawValue, SwiftCalculatorButton.MINUS.rawValue:
                
                switch entries[i - 1] {
                case SwiftCalculatorButton.PLUS.rawValue:
                    a += getEntryWithPercentFactor(entry: entries[i], baseNumber: a)
                case SwiftCalculatorButton.MINUS.rawValue:
                    a -= getEntryWithPercentFactor(entry: entries[i], baseNumber: a)
                case SwiftCalculatorButton.MULTIPLY.rawValue:
                    b *= getEntryWithPercentFactor(entries[i])
                    a += b
                    b = Decimal.zero
                case SwiftCalculatorButton.DIVIDE.rawValue:
                    var divisor = (try? getDivisor(entries: entries, i: i)) ?? .zero
                    var roundedResult = Decimal()
                    NSDecimalRound(&roundedResult, &divisor, 10, .plain)
                    
                    b /= roundedResult
                    a += b
                    b = Decimal.zero
                    
                default:
                    let isPlus = entries[i - 1] == SwiftCalculatorButton.PLUS.rawValue
                    throw MathError.illegalOperation("Error checking \(isPlus ? "plus" : "minus") tag")
                }
                
            case SwiftCalculatorButton.MULTIPLY.rawValue:
                
                switch entries[i - 1] {
                case SwiftCalculatorButton.PLUS.rawValue:
                    b = getEntryWithPercentFactor(entry: entries[i], baseNumber: a)
                case SwiftCalculatorButton.MINUS.rawValue:
                    b = -getEntryWithPercentFactor(entry: entries[i], baseNumber: a)
                case SwiftCalculatorButton.MULTIPLY.rawValue:
                    b *= getEntryWithPercentFactor(entries[i])
                case SwiftCalculatorButton.DIVIDE.rawValue:
                    var divisor = (try? getDivisor(entries: entries, i: i)) ?? .zero
                    var roundedResult = Decimal()
                    NSDecimalRound(&roundedResult, &divisor, 10, .plain)
                    
                    b /= roundedResult
                    
                default:
                    throw MathError.illegalOperation("Error checking multiply tag")
                }
                
            case SwiftCalculatorButton.DIVIDE.rawValue:
                
                switch entries[i - 1] {
                case SwiftCalculatorButton.PLUS.rawValue:
                    b = getEntryWithPercentFactor(entry: entries[i], baseNumber: a)
                case SwiftCalculatorButton.MINUS.rawValue:
                    b = -getEntryWithPercentFactor(entry: entries[i], baseNumber: a)
                case SwiftCalculatorButton.MULTIPLY.rawValue:
                    b *= getEntryWithPercentFactor(entries[i])
                case SwiftCalculatorButton.DIVIDE.rawValue:
                    var divisor = (try? getDivisor(entries: entries, i: i)) ?? .zero
                    var roundedResult = Decimal()
                    NSDecimalRound(&roundedResult, &divisor, 10, .plain)
                    
                    b /= roundedResult
                    
                default:
                    throw MathError.illegalOperation("Error checking divide tag")
                }
                
            default:
                throw MathError.illegalOperation("Error checking next operator tag")
            }
            
        }
        
        throw MathError.illegalOperation("Error solving equation")
    }
    
}

extension BasicMdasCalculator {
    
    private func getDivisor(entries: Array<String>, i: Int) throws -> Decimal {
        let divisor = getEntryWithPercentFactor(entries[i])
        
        if divisor == 0 {
            throw MathError.divisionByZero("Division by zero error!")
        }
        
        return divisor
    }

    private func getEntryWithPercentFactor(entry: String, baseNumber: Decimal) -> Decimal {

        switch true {
        case entry == SwiftCalculatorButton.DECIMAL.rawValue:
            return Decimal.zero
        case entry.hasSuffix(SwiftCalculatorButton.PERCENT.rawValue):
            let trimmedEntry = String(entry.dropLast())
            let decimalEntry = Decimal(string: trimmedEntry) ?? 0.0
            return (baseNumber * decimalEntry) / Decimal(100.0)
        default:
            return Decimal(string: entry) ?? Decimal.zero
        }
    }

    private func getEntryWithPercentFactor(_ entry: String) -> Decimal {
        
        switch true {
        case entry == SwiftCalculatorButton.DECIMAL.rawValue:
            return Decimal(1)
        case entry.hasSuffix(SwiftCalculatorButton.PERCENT.rawValue):
            let trimmedEntry = String(entry.dropLast())
            let decimalTrimmedEntry = Decimal(string: trimmedEntry) ?? Decimal.zero
            return (decimalTrimmedEntry) / Decimal(100.0)
        default:
            return Decimal(string: entry) ?? Decimal.zero
        }
        
    }
    
}
