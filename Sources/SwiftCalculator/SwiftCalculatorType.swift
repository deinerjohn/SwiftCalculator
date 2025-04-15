//
//  SwiftCalculatorType.swift
//  SwiftCalculator
//
//  Created by Deiner John Calbang on 4/15/25.
//

import Foundation

/// Defines the type of calculator logic used for evaluating expressions.
///
/// Use this to control whether the calculator applies operator precedence rules (MDAS)
/// or evaluates strictly from left to right.
public enum SwiftCalculatorType {
    
    /// Basic calculator using **MDAS** (Multiplication, Division, Addition, Subtraction) rules.
    ///
    /// This calculator respects operator precedence.
    /// - Example: `2 + 3 * 4` evaluates to `14`
    case BASIC_MDAS
    
    /// Basic calculator using **non-MDAS** evaluation.
    ///
    /// This calculator evaluates expressions strictly in the order entered (left to right),
    /// without applying operator precedence.
    /// - Example: `2 + 3 * 4` evaluates to `20` (i.e., `(2 + 3) * 4`)
    case BASIC_NON_MDAS
}
