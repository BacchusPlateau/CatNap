//
//  CatNode.swift
//  CatNap
//
//  Created by Bret Williams on 10/28/18.
//  Copyright © 2018 Bret Williams. All rights reserved.
//

import SpriteKit

class CatNode: SKSpriteNode, EventListenerNode {
    
    func didMoveToScene() {

        let catBodyTexture = SKTexture(imageNamed: "cat_body_outline")
        parent!.physicsBody = SKPhysicsBody(texture: catBodyTexture, size: catBodyTexture.size())
        
    }
    
    
    
}
