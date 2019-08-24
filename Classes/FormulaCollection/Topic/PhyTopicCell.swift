//  Created by dasdom on 23.08.19.
//  
//

import UIKit

class PhyTopicCell: DDHBaseTableViewCell<PhyTopic> {
  
  override func update(with item: PhyTopic) {
    textLabel?.text = item.title
    textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    textLabel?.adjustsFontForContentSizeCategory = true
    
    accessoryType = .disclosureIndicator
  }
}
