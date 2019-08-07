//  Created by dasdom on 04.08.19.
//  
//

import UIKit

class PhySpecialFieldCell: DDHBaseTableViewCell<PhySpecialField> {
  
  override func update(with item: PhySpecialField) {
    textLabel?.text = item.title
    textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    textLabel?.adjustsFontForContentSizeCategory = true
  }
}
