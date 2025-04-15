//
//  ControlProcessor.swift
//  SwiftCalculator
//
//  Created by Deiner John Calbang on 4/15/25.
//

internal class ControlProcessor {
    
    let outputManager: OutputManager
    let clearProcessor: ClearProcessor
    let backspaceProcessor: BackspaceProcessor
    let decimalProcessor: DecimalProcessor
    let numberProcessor: NumberProcessor
    let operatorProcessor: OperatorProcessor
    let percentProcessor: PercentProcessor
    
    init(
        outputManager: OutputManager,
        clearProcessor: ClearProcessor,
        backspaceProcessor: BackspaceProcessor,
        decimalProcessor: DecimalProcessor, numberProcessor: NumberProcessor,
        operatorProcessor: OperatorProcessor,
        percentProcessor: PercentProcessor
    ) {
        self.outputManager = outputManager
        self.clearProcessor = clearProcessor
        self.backspaceProcessor = backspaceProcessor
        self.decimalProcessor = decimalProcessor
        self.numberProcessor = numberProcessor
        self.operatorProcessor = operatorProcessor
        self.percentProcessor = percentProcessor
    }
    
    func setDelegate(_ delegate: SwiftCalculatorDelegate) {
        outputManager.delegate = delegate
    }
    
    static func instance(
        entriesManager: EntriesManager,
        calculatorType: SwiftCalculatorType,
        delegate: SwiftCalculatorDelegate?
    ) -> ControlProcessor {
        
        let outputManager = OutputManager.instance(
            entriesManager: entriesManager,
            calculatorType: calculatorType,
            delegate: delegate
        )
        
        return ControlProcessor(
            outputManager: outputManager,
            clearProcessor: ClearProcessor(entriesManager: entriesManager),
            backspaceProcessor: BackspaceProcessor(entriesManager: entriesManager),
            decimalProcessor: DecimalProcessor(
                entriesManager: entriesManager,
                outputManager: outputManager
            ),
            numberProcessor: NumberProcessor(entriesManager: entriesManager),
            operatorProcessor: OperatorProcessor(
                entriesManager: entriesManager,
                outputManager: outputManager
            ),
            percentProcessor: PercentProcessor(
                entriesManager: entriesManager,
                outputManager: outputManager
            )
        )
    }
}
