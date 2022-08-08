//  Created by Dominik Hauser on 07.08.22.
//  Copyright © 2022 dasdom. All rights reserved.
//

import UIKit

// https://stackoverflow.com/a/71302612/498796
extension UIImage {
  func resized(to size: CGSize) -> UIImage {
    return UIGraphicsImageRenderer(size: size).image { _ in
      draw(in: CGRect(origin: .zero, size: size))
    }
  }

  func resized(width: CGFloat) -> UIImage {
    let size = CGSize(width: width, height: self.size.height * width / self.size.width)
    return UIGraphicsImageRenderer(size: size).image { _ in
      draw(in: CGRect(origin: .zero, size: size))
    }
  }

  func resized(height: CGFloat) -> UIImage {
    let size = CGSize(width: self.size.width * height / self.size.height, height: height)
    return UIGraphicsImageRenderer(size: size).image { _ in
      draw(in: CGRect(origin: .zero, size: size))
    }
  }
}
