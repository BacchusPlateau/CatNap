//
//  GameScene.swift
//  CatNap
//
//  Created by Bret Williams on 10/2/18.
//  Copyright © 2018 Bret Williams. All rights reserved.
//

import SpriteKit

protocol EventListenerNode {
    func didMoveToScene()
}

protocol InteractiveNode {
    func interact()
}

struct PhysicsCategory {
    static let None:    UInt32 = 0
    static let Cat:     UInt32 = 0b1 //1
    static let Block:   UInt32 = 0b10 //2
    static let Bed:     UInt32 = 0b100 //4
    static let Edge:    UInt32 = 0b1000 //8
    static let Label:   UInt32 = 0b10000 //16
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var bedNode: BedNode!
    var catNode: CatNode!
    var playable = true
    var bounces = 0
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if (collision == PhysicsCategory.Label | PhysicsCategory.Edge) {
            print("Bounce!")
            bounces += 1
            if(bounces == 4) {
                let labelNode = (childNode(withName: "EndGameLabel") as! MessageNode) as SKLabelNode
                labelNode.removeFromParent()
            }
        }
        
        if (!playable) {
            return
        }
        
        if (collision == PhysicsCategory.Cat | PhysicsCategory.Bed) {
            win()
            print("Success")
        } else if (collision == PhysicsCategory.Cat | PhysicsCategory.Edge) {
            lose()
            print("Fail")
        }
        
    }
    
    override func didMove(to view: SKView) {
        
        self.isPaused = true
        self.isPaused = false
        
        let maxAspectRatio: CGFloat = 16.0 / 9.0
        let maxAspectRatioHeight = size.width / maxAspectRatio
        let playableMargin: CGFloat = (size.height - maxAspectRatioHeight) / 2
        
        let playableRect = CGRect(x: 0,
                                  y: playableMargin,
                                  width: size.width,
                                  height: size.height - playableMargin * 2)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: playableRect)
        physicsWorld.contactDelegate = self
        physicsBody!.categoryBitMask = PhysicsCategory.Edge
        
        enumerateChildNodes(withName: "//*", using: { node, _ in
            if let eventListenerNode = node as? EventListenerNode {
                eventListenerNode.didMoveToScene()
            }
        })
        
        bedNode = (childNode(withName: "bed") as! BedNode)
        catNode = (childNode(withName: "//cat_body") as! CatNode)  //catNode is not a direct child of the scene
        
        SKTAudio.sharedInstance().playBackgroundMusic("backgroundMusic.mp3")
        
    }
    
    func inGameMessage(text: String) {
        
        let message = MessageNode(message: text)
        message.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(message)
        
    }
    
    func lose() {
        
        playable = false
        
        SKTAudio.sharedInstance().pauseBackgroundMusic()
        SKTAudio.sharedInstance().playSoundEffect("lose.mp3")
        
        inGameMessage(text: "Try again...")
        catNode.wakeUp()
        
        run(SKAction.afterDelay(5, runBlock: newGame))
        
    }
    
    func newGame() {
        
        let scene = GameScene(fileNamed: "GameScene")
        scene!.scaleMode = scaleMode
        view!.presentScene(scene)
        
    }
    
    func win() {
        
        playable = false
        
        SKTAudio.sharedInstance().pauseBackgroundMusic()
        SKTAudio.sharedInstance().playSoundEffect("win.mp3")
        
        catNode.curlAt(scenePoint: bedNode.position)
        
        inGameMessage(text: "Nice job!")
        run(SKAction.afterDelay(5, runBlock: newGame))
        
    }
  
}
