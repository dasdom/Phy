//  Created by Dominik Hauser on 28/04/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation

let DDHPlus = "+"
let DDHMinus = "-"
let DDHTimes = "×"
let DDHDivide = "÷"

struct Calculator {
  func calculate(_ string: String) -> String {
    
    let sum = add(string)
    
    return sum.stringValue
  }
  
  private func add(_ string: String) -> NSDecimalNumber {
    let components = string.split(separator: "+")
    
    var result: NSDecimalNumber = 0
    for component in components {
      let componentString = String(component)
      let substraction = substract(componentString)
      result = result.adding(substraction)
    }
    return result
  }
  
  private func substract(_ string: String) -> NSDecimalNumber {
    let components = string.split(separator: "-")

    guard let firstComponent = components.first else {
      return 0
    }
    
    var result: NSDecimalNumber = multiply(String(firstComponent))
    for component in components.dropFirst() {
      let componentString = String(component)
      let number = multiply(componentString)
      result = result.subtracting(number)
    }
    return result
  }
  
  private func multiply(_ string: String) -> NSDecimalNumber {
    let components = string.split(separator: Character(DDHTimes))
    
    var result: NSDecimalNumber = 1
    for component in components {
      let componentString = String(component)
      let substraction = decimalNumber(componentString)
      result = result.multiplying(by: substraction)
    }
    return result
  }
  
  private func decimalNumber(_ string: String) -> NSDecimalNumber {
    let double = Double(string) ?? 0
    return NSDecimalNumber(floatLiteral: double)
  }
}
