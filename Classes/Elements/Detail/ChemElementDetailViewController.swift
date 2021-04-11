//  Created by dasdom on 14.09.19.
//  
//

import UIKit

class ChemElementDetailViewController: UIViewController {

  let element: ChemElement
  
  init(element: ChemElement) {
    
    self.element = element
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
}
