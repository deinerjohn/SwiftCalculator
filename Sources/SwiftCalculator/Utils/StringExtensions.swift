//
//  StringExtensions.swift
//  SwiftCalculator
//
//  Created by Deiner John Calbang on 4/15/25.
//

import Foundation

extension String {
    func formattedWithCommas() -> String {
        guard let number = Double(self) else { return self }

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        if self.contains(".") {
            let split = self.split(separator: ".")
            let decimalPlaces = split.count > 1 ? min(split[1].count, 10) : 0
            formatter.maximumFractionDigits = decimalPlaces
        } else {
            formatter.maximumFractionDigits = 0
        }

        return formatter.string(from: NSNumber(value: number)) ?? self
    }
    
    func trimLast() -> String {
        var string = self
        string = String(string.dropLast())
        return string
    }
    
}
