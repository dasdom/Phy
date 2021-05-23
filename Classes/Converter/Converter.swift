//  Created by Dominik Hauser on 23/04/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation
import Combine

class Converter: ObservableObject, Equatable {
  static func == (lhs: Converter, rhs: Converter) -> Bool {
    return lhs.convertInfo == rhs.convertInfo
  }
  
  
  let convertInfo: ConvertInfo
  @Published var input: String = "" {
    didSet {
      updateOutput()
    }
  }
  @Published var output: String = ""
  @Published var selectedInputIndex = 0 {
    didSet {
      updateOutput()
    }
  }
  @Published var selectedOutputIndex = 1 {
    didSet {
      updateOutput()
    }
  }
  
  init(convertInfo: ConvertInfo) {
    self.convertInfo = convertInfo
  }
  
  func updateOutput() {
    if input.count > 0 {
      let calcString = String(format: "%@%@%@%@%@", input, DDHTimes, convertInfo.units[selectedInputIndex].value, DDHDivide, convertInfo.units[selectedOutputIndex].value)
      
      print("calcString: \(calcString)")
      
      let calculator = Legacy_Calculator(deg: true)
      let result = calculator?.calculate(calcString)
      
      output = Legacy_Calculator.string(fromResult: result)
    } else {
      output = ""
    }
  }
}
