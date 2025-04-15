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
        let delegate = self
        calculator = SwiftCalculator.instance(
            calculatorType: .BASIC_MDAS, // or any other type
            initialNumber: 0.0,
            readyToClear: true,
            delegate: delegate
        )
    }

    // Handle calculator updates
    func onUpdateCalculator(update: SwiftCalculatorUpdate) {
        // You can update UI elements here
        print("Calculator updated: \(update)")
    }
}

```

### SwiftUI Example (by way of creating a ViewModel)

```swift

import SwiftUI
import SwiftCalculator

class CalculatorViewModel: ObservableObject, SwiftCalculatorDelegate {
    @Published var result: String = "0"
    private var calculator: SwiftCalculator!

    init() {
        let delegate = self
        calculator = SwiftCalculator.instance(
            calculatorType: .BASIC_MDAS,
            initialNumber: 0.0,
            readyToClear: true,
            delegate: delegate
        )
    }

    // Handle calculator updates
    func onUpdateCalculator(update: SwiftCalculatorUpdate) {
        result = "\(calculator.getCurrentNumber())"
    }

    // Methods for interacting with the calculator
    func pressDigit(_ digit: Int) {
        calculator.press(.digit(digit))
    }

    func pressAdd() {
        calculator.press(.add)
    }

    func pressEqual() {
        calculator.press(.equal)
    }

    func pressReset() {
        calculator.resetToNumber(number: 0.0, readyToClear: true)
    }
}


```

In the `CalculatorViewModel`:

The `@Published var result` property is updated whenever the calculator state changes.

Methods like `pressDigit()`, `pressAdd()`, and `pressEqual()` are responsible for interacting with the SwiftCalculator.


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

  
