//  Created by Dominik Hauser on 28/04/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation

struct CalculationGrouper {
  func group(string: String) -> [Range<String.Index>] {
    
    var ranges: [Range<String.Index>] = []
    var indicesOfOpenParentheses: [Int] = []
    for (idx, char) in string.enumerated() {
      if char == "(" {
        indicesOfOpenParentheses.append(idx)
      } else if char == ")", indicesOfOpenParentheses.count > 0 {
        
        let lastIndex = indicesOfOpenParentheses.removeLast()
        
        let nsRange = NSRange(location: lastIndex, length: idx-lastIndex)
        if let range = Range<String.Index>(nsRange, in: string) {
          ranges.append(range)
        }
      }
    }
    
    return ranges
  }
}
