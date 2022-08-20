//  Created by Dominik Hauser on 09/04/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit
import SwiftUI

class AppCoordinator: Coordinator {
  
  private let window: UIWindow
  let tabBarController: UITabBarController
  private(set) var childCoordinators: [Coordinator] = []
  lazy var formulaStore: FormulaStoreProtocol = FormulaStore()
  
  init(window: UIWindow) {
    self.window = window
    self.tabBarController = UITabBarController()
  }
  
  func start() {
    tabBarController.viewControllers = [formulas, converter, favorites]
    
    window.rootViewController = tabBarController
    window.makeKeyAndVisible()
  }

  private var formulas: UIViewController {
    let navigationController = UINavigationController()
    navigationController.navigationBar.prefersLargeTitles = true
    let phyTopicCoordinator = FormulasCoordinator(presenter: navigationController, formulaStore: formulaStore)
    phyTopicCoordinator.start()
    childCoordinators.append(phyTopicCoordinator)
    
    navigationController.tabBarItem = UITabBarItem(title: "Formeln".localized, image: UIImage(systemName: "function"), tag: 0)
    return navigationController
  }
  
  private var converter: UIViewController {
    let viewController = UIHostingController(rootView: ConverterList())
    viewController.tabBarItem = UITabBarItem(title: "Konverter".localized, image: UIImage(systemName: "arrow.left.arrow.right"), tag: 1)
    return viewController
  }
  
  private var favorites: UIViewController {
    let navigationController = UINavigationController()
    navigationController.navigationBar.prefersLargeTitles = true
    let favoritesCoordinator = FavoritesCoordinator(presenter: navigationController, formulaStore: formulaStore)
    favoritesCoordinator.start()
    childCoordinators.append(favoritesCoordinator)
    
    navigationController.tabBarItem = UITabBarItem(title: "Lesezeichen".localized, image: UIImage(systemName: "bookmark"), tag: 2)
    return navigationController
  }
}
