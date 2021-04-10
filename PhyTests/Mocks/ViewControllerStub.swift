//  Created by Dominik Hauser on 10/04/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit

class ViewControllerStub: UIViewController {

  var lastPresentedViewController: UIViewController?
  
  override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
    lastPresentedViewController = viewControllerToPresent
    super.present(viewControllerToPresent, animated: flag, completion: completion)
  }
}
