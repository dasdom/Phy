//  Created by dasdom on 17.08.19.
//  
//

import UIKit

extension UIImageView {
  func update(heightConstraint: NSLayoutConstraint?, fontMetrics: UIFontMetrics = UIFontMetrics(forTextStyle: .body)) {
    
    guard let image = image else { return }
    let height = floor(fontMetrics.scaledValue(for: image.size.height * 2.5))
    
    guard let heightConstraint = heightConstraint else { return }
    heightConstraint.constant = height
  }
}
