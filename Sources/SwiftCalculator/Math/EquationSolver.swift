//
//  EquationSolver.swift
//  SwiftCalculator
//
//  Created by Deiner John Calbang on 4/15/25.
//

import Foundation


class EquationSolver {
    
    private let entriesCalculator: EntriesCalculator
    
    init(entriesCalculator: EntriesCalculator) {
        self.entriesCalculator = entriesCalculator
    }
    
    func solve(entries: Array<String>) throws -> Decimal {
        return try entriesCalculator.solve(entries)
    }
    
    static func instance(_ calculatorType: SwiftCalculatorType) -> EquationSolver {

        switch calculatorType {
        case .BASIC_MDAS:
            return EquationSolver(entriesCalculator: BasicMdasCalculator())
        case .BASIC_NON_MDAS:
            return EquationSolver(entriesCalculator: BasicNonMdasCalculator())
        }
        
    }
    
}
