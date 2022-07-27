//  Created by Dominik Hauser on 09/07/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit

class FavoritesCoordinator: FormulasCoordinator {

  override func start() {
    let viewController = FavoritesViewController(formulaStore: formulaStore)
    viewController.delegate = self
    viewController.title = "Favoriten".localized

    presenter.pushViewController(viewController, animated: false)
  }
}
