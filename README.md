## SwiftCalculator
A lightweight calculator library engine written in Swift, this package allows you to plug in calculator logic into your custom iOS/macOS UI design. 

This means you can easily plug the logic into **any custom UI** — whether it's a standard UIKit view, SwiftUI interface. You have full control over how your calculator looks and behaves visually, while this package handles all the logic under the hood.

## Inspired By
This Swift package is a **recreation of [KotlinCalculator](https://github.com/jairrab/KotlinCalculator)** — same core logic, rewritten in Swift.

## Installation

### Swift Package Manager (SPM)

You can install **SwiftCalculator** using **Swift Package Manager**.

#### In Xcode:

1. Open your Xcode project
2. Go to **File > Add Packages Dependencies**
3. Enter the repository URL:
   ```
   
   https://github.com/deinerjohn/SwiftCalculator.git
   
   ```
4. Select the version you want (e.g. from `1.0.0`)
5. Click **Add Package**

#### Or add it manually in your `Package.swift`:

```swift

dependencies: [
 .package(url: "https://github.com/deinerjohn/SwiftCalculator.git", from: "1.0.0")
]

```
Then add "SwiftCalculator" as a dependency to your target.

```swift

.target(
    name: "YourApp",
    dependencies: ["SwiftCalculator"]
)

```

## Usage
Once you’ve installed SwiftCalculator, you can easily integrate it into your app by following these steps.


### UIKit Example

```swift

import SwiftCalculator
import UIKit

class ViewController: UIViewController, SwiftCalculatorDelegate {

    var calculator: SwiftCalculator!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the calculator
        calculator = SwiftCalculatorUtility.instance(
            calculatorType: .BASIC_MDAS,
            initialNumber: 0.0,
            readyToClear: true,
            delegate: self
        )
    }

    // Handle calculator updates
    func onUpdateCalculator(update: SwiftCalculatorUpdate) {
        switch update {
        case .initializing(let number, let entries):
            //TODO:
            break
        case .updating(let key, let entries, let result2, let resultString):
            //TODO:
            break
        case .error(let swiftCalculatorError):
            //TODO:
            break
        }
    }
}

```

### SwiftUI Example (by way of creating a ViewModel)

```swift

class CalculatorViewModel: ObservableObject, SwiftCalculatorDelegate {
    
    @Published var expression: String = ""
    @Published var result: String = "0"
    private var calculator: SwiftCalculator!

    init() {
        calculator = SwiftCalculatorUtility.instance(
            calculatorType: .BASIC_MDAS,
            initialNumber: 0.0,
            readyToClear: true,
            delegate: self
        )
        
    }
    
    func pressDigit(_ digit: Int) {
        calculator.press(.DIGIT(digit))
    }

    func pressEqual() {
        calculator.press(.EQUALS)
        result = "\(calculator.getCurrentFormattedResult())"
    }

    func pressReset() {
        calculator.resetToNumber(number: 0.0, readyToClear: true)
    }
    
    func pressBackspace() {
        calculator.press(.BACKSPACE)
    }
    
    func pressClear() {
        calculator.press(.CLEAR)
        result = "0"
    }
    
    func pressDecimal() {
        calculator.press(.DECIMAL)
    }
    
    func pressPercent() {
        calculator.press(.PERCENT)
    }
    
    func onUpdateCalculator(update: SwiftCalculatorUpdate) {
        switch update {
        case .initializing(let number, let entries):
            break
        case .updating(let key, let entries, let formattedEntries, let result2, let resultString):
            expression = formattedEntries.joined()
            break
        case .error(let swiftCalculatorError):
            break
        }
    }
    
    func operand(_ operand: String) {
        switch CalculatorOperand(rawValue: operand) {
        case .add:
            calculator.press(.PLUS)
        case .minus:
            calculator.press(.MINUS)
        case .multiply:
            calculator.press(.MULTIPLY)
        case .divide:
            calculator.press(.DIVIDE)
            
        default: break
        }
        
        //Call to get current result
        result = "\(calculator.getCurrentFormattedResult())"
    }
    
}


```

### SwiftUI View Example Usage

```swift


struct CalculatorView: View {
    @StateObject private var viewModel = CalculatorViewModel()

    let buttons: [[String]] = [
        ["⌫", "Clear", "%", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "−"],
        ["1", "2", "3", "+"],
        ["0", ".", "="]
    ]

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text(viewModel.expression)
                .font(.title2)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal)
            
            // Display
            Text(viewModel.result)
                .font(.system(size: 64))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
                .lineLimit(1)
            

            // Buttons
            ForEach(buttons, id: \.self) { row in
                HStack(spacing: 12) {
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            handleButtonPress(button)
                        }) {
                            Text(button)
                                .font(.system(size: 32))
                                .frame(width: self.buttonWidth(button), height: self.buttonHeight())
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(self.buttonWidth(button) / 2)
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    private func handleButtonPress(_ button: String) {
        print(button)
        switch button {
        case ".":
            self.viewModel.pressDecimal()
        case "0"..."9":
            self.viewModel.pressDigit(Int(button) ?? 0)
        case "%":
            self.viewModel.pressPercent()
        case "−":
            self.viewModel.operand("--")
        case "+", "÷":
            self.viewModel.operand(button)
        case "×":
            self.viewModel.operand("xx")
        case "=":
            self.viewModel.pressEqual()
        case "⌫":
            self.viewModel.pressBackspace()
        case "Clear":
            self.viewModel.pressClear()
        default:
            break
        }
    }

    private func buttonWidth(_ button: String) -> CGFloat {
        return button == "0" ? ((UIScreen.main.bounds.width - 5 * 12) / 2) : ((UIScreen.main.bounds.width - 5 * 12) / 4)
    }

    private func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
    
}


```



In the `CalculatorViewModel`:

The `@Published var result` property is updated whenever the calculator state changes.

## SwiftCalculatorDelegate
This method, `onUpdateCalculator(update:)`, is called by the `SwiftCalculator` to send updates whenever a significant change occurs. This could include changes to the current result, a button press, or any internal state changes.

## Customization

You have full control over how the calculator behaves by selecting the type (BASIC_MDAS or BASIC_NONMDAS) when creating the instance.

calculatorType: Choose between different calculator modes (e.g., `.BASIC_MDAS` or `.BASIC_NONMDAS`).

Delegate: Attach your custom delegate to handle state changes and updates.

## Roadmap
* Enhanced UI Components: Provide built-in UI components (like buttons and displays) for easier integration with both UIKit and SwiftUI.
* Scientific Calculator Mode: Add additional functionality to support scientific operations (e.g., sin, cos, tan, etc.).
* Custom Themes: Allow customization of button styles, fonts, and colors to fit different app themes.
* Error Handling: Improve error handling with better feedback for invalid operations (like division by zero).
* History Tracking: Add a history feature to keep track of previous calculations or operations.
* Unit Testing: Expand unit tests for different calculator types and ensure full coverage of edge cases.

  
