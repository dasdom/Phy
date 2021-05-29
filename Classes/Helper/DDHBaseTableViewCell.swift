//  Created by dasdom on 05.08.19.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit

class DDHBaseTableViewCell<T>: UITableViewCell {
  
  static var identifier: String {
    return NSStringFromClass(self)
  }
  
  func update(with item: T) {
    
  }
}
