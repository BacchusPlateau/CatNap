//
//  BedNode.swift
//  CatNap
//
//  Created by Bret Williams on 10/28/18.
//  Copyright © 2018 Bret Williams. All rights reserved.
//

import SpriteKit

class BedNode : SKSpriteNode, EventListenerNode {
    
    func didMoveToScene() {
        
        let bedBodySize = CGSize(width: 40.0, height: 30.0)
        physicsBody = SKPhysicsBody(rectangleOf: bedBodySize)
        physicsBody!.isDynamic = false
        
        
    }
    
}
