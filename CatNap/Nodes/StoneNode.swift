//
//  StoneNode.swift
//  CatNap
//
//  Created by Bret Williams on 11/18/18.
//  Copyright © 2018 Bret Williams. All rights reserved.
//

import SpriteKit

class StoneNode : SKSpriteNode , InteractiveNode, EventListenerNode {
    
    static func makeCompoundNode(in scene: SKScene) -> SKNode {
        
        let compound = StoneNode()
        
        for stone in scene.children
            .filter({ node in node is StoneNode}) {
                stone.removeFromParent()
                compound.addChild(stone)
        }
        
        let bodies = compound.children.map { node in
            SKPhysicsBody(rectangleOf: node.frame.size,
                          center: node.position)
        }
        
        compound.physicsBody = SKPhysicsBody(bodies: bodies)
        compound.physicsBody!.collisionBitMask = PhysicsCategory.Edge | PhysicsCategory.Cat | PhysicsCategory.Block
        compound.physicsBody!.categoryBitMask = PhysicsCategory.Block
        compound.isUserInteractionEnabled = true
        compound.zPosition = 1
        
        return compound
        
    }
    
    func didMoveToScene() {
        
        guard let scene = scene else {
            return
        }
        
        if parent == scene {
            
            scene.addChild(StoneNode.makeCompoundNode(in: scene))
            
        }
    }
    
    func interact() {
        
        isUserInteractionEnabled = true
        
        run(SKAction.sequence([
            SKAction.playSoundFileNamed("pop.mp3", waitForCompletion: false),
            SKAction.removeFromParent()
            ]))
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        interact()
    }
    
}
