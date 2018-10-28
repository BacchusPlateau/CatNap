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

class GameScene: SKScene {
    
    
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
        
    }
    
    
  
}
