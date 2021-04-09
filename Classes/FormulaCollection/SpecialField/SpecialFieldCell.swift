//  Created by dasdom on 04.08.19.
//  
//

import UIKit

class SpecialFieldCell: DDHBaseTableViewCell<SpecialField> {
  
  override func update(with item: SpecialField) {
    textLabel?.text = item.title
    textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    textLabel?.adjustsFontForContentSizeCategory = true
    
    accessoryType = .disclosureIndicator
  }
}
