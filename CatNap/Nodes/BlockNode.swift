//
//  BlockNode.swift
//  CatNap
//
//  Created by Bret Williams on 11/3/18.
//  Copyright © 2018 Bret Williams. All rights reserved.
//

import SpriteKit

class BlockNode : SKSpriteNode, InteractiveNode, EventListenerNode {
    
    func didMoveToScene() {
        isUserInteractionEnabled = true
    }
    
    func interact() {
        isUserInteractionEnabled = false
        
        run(SKAction.sequence([
            SKAction.playSoundFileNamed("pop.mp3", waitForCompletion: false),
            SKAction.scale(to: 0.8, duration: 0.1),
            SKAction.removeFromParent()
        ]))
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        interact()
    }
}
