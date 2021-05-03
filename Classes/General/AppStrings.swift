//  Created by Dominik Hauser on 03/05/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation

enum AppStrings: String {
  case asking_for_feedback
  case feedback_call_for_action
  case asing_for_feedback_button
  
  var localized: String {
    return rawValue.localized
  }
}
