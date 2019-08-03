//  Created by dasdom on 26.07.19.
//  
//

import UIKit

class SolverCell: UITableViewCell {
  
  static var identifier: String {
    return NSStringFromClass(self)
  }
  
  func update(with item: SolverTool) {
    
    let image = UIImage(named: item.imageName)
    imageView?.image = image
    
    textLabel?.text = item.title
    textLabel?.textAlignment = .right
  }
}
