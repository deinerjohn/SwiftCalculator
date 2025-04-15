//
//  MathError.swift
//  SwiftCalculator
//
//  Created by Deiner John Calbang on 4/15/25.
//

import Foundation

enum MathError: Error {
    case illegalOperation(String)
    case divisionByZero(String)
}
