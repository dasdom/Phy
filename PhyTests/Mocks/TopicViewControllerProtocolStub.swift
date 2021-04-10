//  Created by Dominik Hauser on 10/04/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit
@testable import Phy

class TopicViewControllerProtocolStub: TopicViewControllerProtocol {
  
  var lastSelectedTopic: Topic?
  var showImprintCallCount = 0
  
  func topicSelected(_ viewController: UIViewController, topic: Topic) {
    lastSelectedTopic = topic
  }
  
  func showImprint(_ viewController: UIViewController) {
    showImprintCallCount += 1
  }
}
