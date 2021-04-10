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
    tabBarController.viewControllers = [formulas, calculator, converter, reference, solver]
    
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
    let viewController = GeneralCalculatorViewController()
    viewController.tabBarItem = UITabBarItem(title: NSLocalizedString("Rechner", comment: ""), image: UIImage(systemName: "plusminus"), tag: 1)
    return viewController
  }
  
  private var converter: UIViewController {
    let viewController = ConverterViewController()
    viewController.tabBarItem = UITabBarItem(title: NSLocalizedString("Konverter", comment: ""), image: UIImage(systemName: "arrow.left.arrow.right"), tag: 2)
    return viewController
  }
  
  private var reference: UIViewController {
    let viewController = ReferenzViewController()
    viewController.tabBarItem = UITabBarItem(title: NSLocalizedString("Referenz", comment: ""), image: UIImage(systemName: "doc.text.magnifyingglass"), tag: 3)
    return viewController
  }
  
  private var solver: UIViewController {
    let viewController = SolverTableViewController()
    viewController.tabBarItem = UITabBarItem(title: NSLocalizedString("Werkzeuge", comment: ""), image: UIImage(systemName: "wrench.and.screwdriver"), tag: 4)
    return UINavigationController(rootViewController: viewController)
  }
}
