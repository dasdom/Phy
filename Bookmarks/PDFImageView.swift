//  Created by Dominik Hauser on 29.07.22.
//  Copyright © 2022 dasdom. All rights reserved.
//

import SwiftUI
import UIKit

// https://stackoverflow.com/a/61178828/498796
struct PDFImageView: UIViewRepresentable {
  var name: String
  var contentMode: UIView.ContentMode = .scaleAspectFit
  var tintColor: UIColor = .black

  func makeUIView(context: Context) -> UIImageView {
    let imageView = UIImageView()
    imageView.setContentCompressionResistancePriority(.fittingSizeLevel,
                                                      for: .vertical)
    return imageView
  }

  func updateUIView(_ uiView: UIImageView, context: Context) {
    uiView.contentMode = contentMode
    uiView.tintColor = tintColor
    if let image = UIImage(named: name) {
      uiView.image = image
    }
  }
}
