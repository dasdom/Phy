//  Created by Dominik Hauser on 22/05/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import SwiftUI

struct CalcButton: View {
  
  let value: String
  @Binding var input: String
  
  var body: some View {
    Button(value, action: { input.append(value) })
  }
}

struct CalcButton_Previews: PreviewProvider {
  
  @State static var input: String = "in"
  
  static var previews: some View {
    CalcButton(value: "Foobar", input: $input)
  }
}
