//
//  CatNode.swift
//  CatNap
//
//  Created by Bret Williams on 10/28/18.
//  Copyright © 2018 Bret Williams. All rights reserved.
//

import SpriteKit

class CatNode: SKSpriteNode, EventListenerNode, InteractiveNode {
    
    static let kCatTappedNotification = "kCatTappedNotification"
    
    func curlAt(scenePoint: CGPoint) {
        
        parent!.physicsBody = nil
        
        for child in children {
            child.removeFromParent()
        }
        
        texture = nil
        color = SKColor.clear
        
        let catCurl = SKSpriteNode(fileNamed: "CatCurl")!.childNode(withName: "cat_curl")!
        
        catCurl.move(toParent: self)
        catCurl.position = CGPoint(x: -30, y: 100)
        
        var localPoint = parent!.convert(scenePoint, from: scene!)
        localPoint.y += frame.size.height / 3
        
        run(SKAction.group([
            SKAction.move(to: localPoint, duration: 0.66),
            SKAction.rotate(toAngle: -parent!.zRotation, duration: 0.5)
            ]))
        
    }
    
    func curlAt2(scenePoint: CGPoint) {
        
        parent!.physicsBody = nil
        
        for child in children {
            print("remove")
            child.removeFromParent()
        }
        
        zPosition = -2
        texture = nil
        color = SKColor.clear
        
//        let catCurl = SKSpriteNode(fileNamed: "CatCurl")!.childNode(withName: "cat_curl")!
        
//        catCurl.move(toParent: self)
 //       catCurl.
        
        var localPoint = parent!.convert(scenePoint, from: scene!)
        localPoint.y += frame.size.height / 3
    
        position = CGPoint(x: -30, y: 100)
        let tex1 = SKTexture(imageNamed: "cat_curlup1")
        let Tsize = CGSize(width: 380, height: 440)
        size = Tsize
        let tex2 = SKTexture(imageNamed: "cat_curlup2")
        let tex3 = SKTexture(imageNamed: "cat_curlup3")
        
        let animate = SKAction.animate(with: [tex1, tex2, tex3], timePerFrame: 0.33)
     //   run(animate)
        print("animate")
        run(SKAction.group([
            SKAction.move(to: localPoint, duration: 0.66),
            SKAction.rotate(toAngle: -parent!.zRotation, duration: 0.5),
            animate
            ]))
        
    }
    
    func didMoveToScene() {

        let catBodyTexture = SKTexture(imageNamed: "cat_body_outline")
        parent!.physicsBody = SKPhysicsBody(texture: catBodyTexture, size: catBodyTexture.size())
        parent!.physicsBody!.categoryBitMask = PhysicsCategory.Cat
        parent!.physicsBody!.collisionBitMask = PhysicsCategory.Block | PhysicsCategory.Edge | PhysicsCategory.Spring
        parent!.physicsBody!.contactTestBitMask = PhysicsCategory.Bed | PhysicsCategory.Edge
        isUserInteractionEnabled = true
        
    }
    
    func interact() {
        
        NotificationCenter.default.post(Notification(name:
            NSNotification.Name(CatNode.kCatTappedNotification),
                                                     object: nil))
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        interact()
    }
    
    func wakeUp() {
        
        for child in children {
            child.removeFromParent()
        }
        
        texture = nil
        color = SKColor.clear
        
        let catAwake = SKSpriteNode(fileNamed: "CatWakeUp")!.childNode(withName: "cat_awake")!
        
        catAwake.move(toParent: self)
        catAwake.position = CGPoint(x: -30, y: 100)
        
    }
    
    
    
}
