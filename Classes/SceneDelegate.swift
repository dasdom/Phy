//  Created by dasdom on 16.11.19.
//  Copyright © 2019 dasdom. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  var appCoordinator: AppCoordinator?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
    guard let scene = (scene as? UIWindowScene) else { return }

    window = UIWindow(windowScene: scene)

    appCoordinator = AppCoordinator(window: window!)
    appCoordinator?.start()

    opened(with: connectionOptions.urlContexts)
  }

  func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    opened(with: URLContexts)
  }

  private func opened(with urlContexts: Set<UIOpenURLContext>) {
    if let url = urlContexts.first(where: { $0.url.scheme == "widget" })?.url {
      print("url: \(url)")

      let components = URLComponents(url: url, resolvingAgainstBaseURL: false)

      appCoordinator?.tabBarController.selectedIndex = 2

      if let host = components?.host,
         let favoritesCoordinator = appCoordinator?.childCoordinators.first(where: { $0 is FavoritesCoordinator }) as? FavoritesCoordinator {

        favoritesCoordinator.start()
        
        if let id = UUID(uuidString: host) {
          favoritesCoordinator.showFormula(with: id)
        }
      }
    }
  }
}

