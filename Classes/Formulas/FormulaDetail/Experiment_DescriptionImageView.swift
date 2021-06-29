//  Created by Dominik Hauser on 29/06/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import SwiftUI

struct DescriptionImageView: View {

  let item: FormulaDetailItem
  @ScaledMetric var imageScale: CGFloat = 1
  let fontMetrics = UIFontMetrics(forTextStyle: .body)

  var body: some View {

    Image(item.imageName)
      .resizable()
      .aspectRatio(contentMode: .fit)
      .scaleEffect(imageScale)
  }
}

struct DescriptionImageView_Previews: PreviewProvider {
  static var previews: some View {
    DescriptionImageView(item: FormulaDetailItem(imageName: "mechanics_friction_force"))
  }
}
