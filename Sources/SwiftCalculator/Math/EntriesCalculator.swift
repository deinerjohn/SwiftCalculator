//
//  EntriesCalculator.swift
//  SwiftCalculator
//
//  Created by Deiner John Calbang on 4/15/25.
//

import Foundation

protocol EntriesCalculator {
    func solve(_ entries: Array<String>) throws -> Decimal
}
