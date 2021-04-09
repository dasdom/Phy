//  Created by Dominik Hauser on 09/04/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit

class FormulasCoordinator: Coordinator {
  
  private let presenter: UINavigationController
  private let viewController: TopicViewController

  init(presenter: UINavigationController) {
    self.presenter = presenter
    let topicDataSource = TopicDataSource()
    viewController = TopicViewController(dataSource: topicDataSource)
  }
  
  func start() {
    viewController.delegate = self
    presenter.pushViewController(viewController, animated: false)
  }
}

extension FormulasCoordinator: TopicViewControllerProtocol {
  func viewController(_ viewController: UIViewController, topicSelected topic: Topic) {
    
    let dataSource = SpecialFieldDataSource(json: topic.json)
    let next = SpecialFieldsViewController(style: .grouped, dataSource: dataSource)
    presenter.pushViewController(next, animated: true)
  }
}
