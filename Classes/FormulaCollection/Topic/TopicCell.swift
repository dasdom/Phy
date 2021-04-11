//  Created by dasdom on 23.08.19.
//  
//

import UIKit

class TopicCell: DDHBaseTableViewCell<Topic> {
  
  override func update(with item: Topic) {
    textLabel?.text = NSLocalizedString(item.title, comment: "")
    textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    textLabel?.adjustsFontForContentSizeCategory = true
    
    accessoryType = .disclosureIndicator
  }
}
