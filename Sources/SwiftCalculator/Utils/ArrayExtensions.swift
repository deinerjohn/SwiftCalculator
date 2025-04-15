//
//  ArrayExtensions.swift
//  SwiftCalculator
//
//  Created by Deiner John Calbang on 4/15/25.
//

import Foundation

extension Array where Element == String {
    func replacingMathSymbols() -> [String] {
        return self.map { element in
            switch element {
            case "/": return "÷"
            case "*": return "×"
            default: return element
            }
        }
    }
}
