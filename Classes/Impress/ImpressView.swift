//  Created by dasdom on 23.07.19.
//  Copyright © 2019 dasdom. All rights reserved.
//

import UIKit
import SpriteKit

class ImpressView: UIView, UITextViewDelegate {
  
  let caveScene: CaveScene
  let gameView: SKView
  let textView: UITextView
  private var alreadyStarted = false

  override init(frame: CGRect) {
    
    let gameFrame = CGRect(x: 0, y: 0, width: 750, height: 400)
    caveScene = CaveScene(size: gameFrame.size)
    caveScene.scaleMode = .aspectFill
    caveScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)

    gameView = SKView(frame: gameFrame)
    gameView.ignoresSiblingOrder = true
    
//    gameView.showsFPS = true
//    gameView.showsNodeCount = true
    
    textView = UITextView()
    textView.isEditable = false
    textView.isSelectable = false
    textView.decelerationRate = .fast
    
    super.init(frame: frame)
    
    backgroundColor = .white
    
    textView.delegate = self

    caveScene.impressView = self
    gameView.presentScene(startScene)
    
    let stackView = UIStackView(arrangedSubviews: [gameView, textView])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.distribution = .fill
    
    addSubview(stackView)
    
    let gameViewHeightConstraint = gameView.heightAnchor.constraint(equalToConstant: 200)
    gameViewHeightConstraint.priority = UILayoutPriority(999)
    
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      gameViewHeightConstraint,
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
      ])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  fileprivate lazy var startScene: StartScene = {
    let size = CGSize(width: 375, height: 200)
    let startScene = StartScene(size: size)
    startScene.backgroundColor = .black
    startScene.textColor = .white
    return startScene
  }()
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let percentage = scrollView.contentOffset.y / (scrollView.contentSize.height - scrollView.frame.size.height);
    
    if false == alreadyStarted {
      alreadyStarted = true
      gameView.presentScene(caveScene, transition: .doorsOpenHorizontal(withDuration: 0.5))
      caveScene.scrollSpeed = 1
    } else {
      caveScene.updatePosition(for: percentage)
    }
    
  }
  
  func didFinish() {
    startScene.title = "Game Over"
    startScene.subTitle = "Have fun with the impress!"
    gameView.presentScene(startScene, transition: .doorsCloseHorizontal(withDuration: 0.5))
  }
}
