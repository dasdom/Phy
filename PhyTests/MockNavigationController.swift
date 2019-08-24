//  Created by dasdom on 11.08.19.
//  
//

import UIKit

class MockNavigationController : UINavigationController {
  
  var lastPushedViewController: UIViewController? = nil
  
  override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    lastPushedViewController = viewController
    
    super.pushViewController(viewController, animated: true)
  }
}
