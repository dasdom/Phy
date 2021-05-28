//  Created by Dominik Hauser on 24/05/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation

class CalculatorConstant: NSObject, Decodable {
  
  enum CodingKeys: String, CodingKey {
    case name
    case value
    case unit
  }
  
  let id = UUID()
  @objc let name: String
  @objc let value: String
  @objc let unit: String
  
  @objc class func allConstants() -> [CalculatorConstant] {
    guard let url = Bundle.main.url(forResource: "calculator_constants", withExtension: "json") else {
      return []
    }
    let constants: [CalculatorConstant]
    do {
      let data = try Data(contentsOf: url)
      constants = try JSONDecoder().decode([CalculatorConstant].self, from: data)
    } catch {
      print("error: \(error)")
      constants = []
    }
    return constants
  }
}
