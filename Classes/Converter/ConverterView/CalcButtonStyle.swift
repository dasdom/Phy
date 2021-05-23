//  Created by Dominik Hauser on 22/05/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import SwiftUI

// https://www.fivestars.blog/articles/button-styles/
struct CalcButtonStyle: ButtonStyle {
  
  let color: Color
  
  func makeBody(configuration: Configuration) -> some View {
    VStack {
      Spacer()
      HStack {
        Spacer()
        configuration.label
        Spacer()
      }
      Spacer()
    }
    .border(Color.gray, width: 0.5)
    .background(color)
    .scaleEffect(configuration.isPressed ? 0.95 : 1)
  }
}
