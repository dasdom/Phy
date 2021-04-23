//  Created by Dominik Hauser on 23/04/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation
import Combine

class Converter: ObservableObject {
  
  let convertInfo: ConvertInfo
  @Published var input: String = ""
  @Published var selectedInputIndex = 0 {
    didSet {
      print("inputIndex: \(selectedInputIndex)")
    }
  }
  @Published var selectedOutputIndex = 0
  var tokens: Set<AnyCancellable> = []
  
  init(convertInfo: ConvertInfo) {
    self.convertInfo = convertInfo
    
    $input.sink { [weak self] input in
      
      guard let self = self else {
        return
      }
      
      print("input: \(input)")
      let calcString = String(format: "%@%@%@%@%@", input, DDHTimes, convertInfo.units[self.selectedInputIndex].value, DDHDivide, convertInfo.units[self.selectedOutputIndex].value)
      
      print("calcString: \(calcString)")
    }.store(in: &tokens)

  }
}
