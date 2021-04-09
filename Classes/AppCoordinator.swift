//  Created by Dominik Hauser on 09/04/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
  
  private let window: UIWindow
  private let tabBarController: UITabBarController
  private var childCoordinators: [Coordinator] = []
  
  init(window: UIWindow) {
    self.window = window
    self.tabBarController = UITabBarController()
  }
  
  func start() {
    tabBarController.viewControllers = [formulas, calculator]
    
    window.rootViewController = tabBarController
    window.makeKeyAndVisible()
  }
  
  private var formulas: UIViewController {
    let formulasNavigationController = UINavigationController()
    let phyTopicCoordinator = FormulasCoordinator(presenter: formulasNavigationController)
    phyTopicCoordinator.start()
    childCoordinators.append(phyTopicCoordinator)
    
    formulasNavigationController.tabBarItem = UITabBarItem(title: NSLocalizedString("Formeln", comment: ""), image: UIImage(systemName: "function"), tag: 0)
    return formulasNavigationController
  }
  
  private var calculator: UIViewController {
    let calculator = GeneralCalculatorViewController()
    calculator.tabBarItem = UITabBarItem(title: NSLocalizedString("Rechner", comment: ""), image: UIImage(systemName: "plusminus"), tag: 1)
    return calculator
  }
}
