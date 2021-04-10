//  Created by Dominik Hauser on 10/04/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit
@testable import Phy

class SpecialFieldsViewControllerProtocolStub: SpecialFieldsViewControllerProtocol {
  
  var lastSelectedSpecialField: SpecialField?
  
  func specialFieldSelected(_ viewController: UIViewController, specialField: SpecialField) {
    lastSelectedSpecialField = specialField
  }
}
