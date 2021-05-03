//  Created by Dominik Hauser on 03/05/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import SwiftUI

protocol FeedbackViewDelegate {
  func composeMail()
}

struct FeedbackView: View {
  
  let delegate: FeedbackViewDelegate
  
  var body: some View {
    VStack {
      VStack(spacing: 10) {
        Text(AppStrings.asking_for_feedback.localized)
          .font(.headline)
        
        Text(AppStrings.feedback_call_for_action.localized)
      }
      .padding()
  
      Button(AppStrings.asing_for_feedback_button.localized) {
        delegate.composeMail()
      }
      
      Spacer()
    }
  }
}

struct FeedbackView_Previews: PreviewProvider {
  
  class PreviewFeedbackViewDelegate: FeedbackViewDelegate {
    func composeMail() {
    }
  }
  
  static var previews: some View {
    FeedbackView(delegate: PreviewFeedbackViewDelegate())
  }
}
