//  Created by dasdom on 23.07.19.
//  Copyright © 2019 dasdom. All rights reserved.
//

import UIKit
import SpriteKit

class StartScene: SKScene {
  
  var contentCreated = false
  
  var title: String = "Spaceship" {
    didSet {
      startLabelNode.text = title
    }
  }
  
  var subTitle: String = "Scroll to move spaceship" {
    didSet {
      descriptionLabelNode.text = subTitle
    }
  }
  
  var textColor = SKColor.black {
    didSet {
      self.startLabelNode.fontColor = textColor
      self.descriptionLabelNode.fontColor = textColor
    }
  }
  
  lazy var startLabelNode: SKLabelNode = {
    let startNode = SKLabelNode(text: title)
    startNode.fontColor = self.textColor
    startNode.fontSize = 40
    startNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
    startNode.name = "start"
    
    return startNode
  }()
  
  lazy var descriptionLabelNode: SKLabelNode = {
    let descriptionNode = SKLabelNode(text: subTitle)
    descriptionNode.fontColor = self.textColor
    descriptionNode.fontSize = 27
    descriptionNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY-40)
    descriptionNode.name = "description"
    
    return descriptionNode
  }()
  
  override func didMove(to view: SKView) {
    super.didMove(to: view)
    if !contentCreated {
      createSceneContents()
      contentCreated = true
    }
  }
  
  func createSceneContents() {
    scaleMode = .aspectFit
    addChild(startLabelNode)
    addChild(descriptionLabelNode)
  }
}
