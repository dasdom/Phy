//  Created by dasdom on 23.07.19.
//  Copyright © 2019 dasdom. All rights reserved.
//

import UIKit
import SpriteKit

class CaveScene: SKScene, SKPhysicsContactDelegate {

  var spaceship: SKSpriteNode?
  var pathTop: SKShapeNode?
  var pathBottom: SKShapeNode?
  var scrollSpeed: CGFloat = 0
  var sparkEmitter: SKEmitterNode?
  weak var impressView: ImpressView?

  override func didMove(to view: SKView) {
    
    var pointsTop: [CGPoint] = []
    var pointsBottom: [CGPoint] = []
    
    let wallCategory   : UInt32 = 0x1 << 1
    let spaceshipCategory : UInt32 = 0x1 << 2
    
    physicsWorld.contactDelegate = self
    
    pointsTop.append(CGPoint(x: -size.width/2.0, y: size.height/2.0-20))
    pointsBottom.append(CGPoint(x: -size.width/2.0, y: -size.height/2.0+20))

    pointsTop.append(CGPoint(x: 0.0, y: size.height/2.0-20))
    pointsBottom.append(CGPoint(x: 0.0, y: -size.height/2.0+20))
  
    for i in 1..<100 {
      let y: CGFloat = CGFloat(arc4random_uniform(280))-100.0
      pointsTop.append(CGPoint(x: CGFloat(i)*200.0+size.width/4.0, y: y))
      pointsBottom.append(CGPoint(x: CGFloat(i)*200.0+size.width/4.0, y: y-80.0))
    }
    
    pathTop = SKShapeNode(points: &pointsTop, count: pointsTop.count)
    
    guard let pathTop = pathTop else { fatalError() }
    pathTop.lineWidth = 10
    pathTop.strokeColor = .white
    
    guard let topPath = pathTop.path else { fatalError() }
    pathTop.physicsBody = SKPhysicsBody(edgeChainFrom: topPath)
    pathTop.physicsBody?.affectedByGravity = false
    pathTop.physicsBody?.categoryBitMask = wallCategory
    pathTop.physicsBody?.contactTestBitMask = spaceshipCategory
    pathTop.physicsBody?.collisionBitMask = spaceshipCategory
    
    addChild(pathTop)
    
    pathBottom = SKShapeNode(points: &pointsBottom, count: pointsBottom.count)
    
    guard let pathBottom = pathBottom else { fatalError() }
    pathBottom.lineWidth = 10
    pathBottom.strokeColor = .white
    
    guard let bottomPath = pathBottom.path else { fatalError() }
    pathBottom.physicsBody = SKPhysicsBody(edgeChainFrom: bottomPath)
    pathBottom.physicsBody?.affectedByGravity = false
    pathBottom.physicsBody?.categoryBitMask = wallCategory
    pathBottom.physicsBody?.contactTestBitMask = spaceshipCategory
    pathBottom.physicsBody?.collisionBitMask = spaceshipCategory
    
    addChild(pathBottom)
    
    spaceship = SKSpriteNode(color: UIColor.red, size: CGSize(width: 10, height: 10))
    
    guard let spaceship = spaceship else { return }
    
    let physicsBody = SKPhysicsBody(rectangleOf: spaceship.size)
    physicsBody.restitution = 0.5
    physicsBody.affectedByGravity = false
    physicsBody.categoryBitMask = spaceshipCategory
    physicsBody.contactTestBitMask = wallCategory
    physicsBody.collisionBitMask = wallCategory
    
    spaceship.physicsBody = physicsBody
    
    addChild(spaceship)
    updatePosition(for: 0)
    
    preloadParticles()
  }
  
  func preloadParticles() {
    sparkEmitter = SKEmitterNode(fileNamed: "Spark")
  }
  
  func didBegin(_ contact: SKPhysicsContact) {
    
    scrollSpeed = 0
    
    guard let emitterCopy = sparkEmitter?.copy() as? SKEmitterNode else { fatalError() }
    guard let spaceship = spaceship else { fatalError() }
    emitterCopy.position = spaceship.position
    addChild(emitterCopy)
    
    emitterCopy.run(SKAction.sequence([SKAction.wait(forDuration: 0.1), SKAction.scale(by: 1.5, duration: 0.1), SKAction.run({
      
      emitterCopy.particleBirthRate = 0;
      SKAction.wait(forDuration: 0.1)
      self.impressView?.didFinish()
      SKAction.run {
        emitterCopy.removeFromParent()
      }
      
    })]))
  }
  
  override func update(_ currentTime: TimeInterval) {
    guard let pathTop = pathTop else { return }
    pathTop.position.x = pathTop.position.x - scrollSpeed
    
    guard let pathBottom = pathBottom else { return }
    pathBottom.position.x = pathBottom.position.x - scrollSpeed
  }
  
  func updatePosition(for percentage: CGFloat) {
    if scrollSpeed > 0 {
      spaceship?.position = CGPoint(x: -size.width/4.0, y: (percentage)*240-120)
    }
  }
}
