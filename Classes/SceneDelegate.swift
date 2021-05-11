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
  }
}

