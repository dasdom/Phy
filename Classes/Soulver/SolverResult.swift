//  Created by dasdom on 26.07.19.
//  
//

import Foundation

struct SolverResult : Codable, Equatable {
  let formula: String
  var unit: String?
  let imageName: String
  var imageNameShort: String?

  func resultString(inputs: [SolverInput], inputValues: [String], result: String) -> String {
    var formulaString = formula

    let numberInputs = inputs.filter({ $0.inputType != .angleType })
    for (idx, input) in numberInputs.enumerated() {
      var userInputElements = [inputValues[idx]]
      if let unit = input.unit {
        userInputElements.append("\(unit)")
      }
      let userInput = userInputElements.joined(separator: " ")
      formulaString = formulaString.replacingOccurrences(of: "#\(input.id)", with: userInput)
    }
    var resultsElements = ["= \(formulaString)\n=", result]
    if let resultUnit = unit {
      resultsElements.append(resultUnit)
    }
    return resultsElements.joined(separator: " ")
  }
}
