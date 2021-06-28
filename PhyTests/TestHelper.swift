//  Created by Dominik Hauser on 19/06/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation

enum Language {
  case en
  case de
}

func language() -> Language {
  if let languageCode = Locale.current.languageCode, languageCode.contains("en") {
    return .en
  } else {
    return .de
  }
}

func tap(_ barButton: UIBarButtonItem) {
  if let action = barButton.action {
    _ = barButton.target?.perform(action, with: barButton)
  }
}
