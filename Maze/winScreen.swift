//
//  winScreen.swift
//  Maze
//
//  Created by  on 6/10/22.
//

import Foundation
import SpriteKit
import GameplayKit


class winScreen: SKScene, SKPhysicsContactDelegate
{
    var win = SKSpriteNode()
    
    override func didMove(to view: SKView)
    {
        win = childNode(withName: "winImage") as! SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if let touch = touches.first
        {
            let location = touch.location(in: self)
            if win.contains(location)
            {
                let gameScene = GameScene(fileNamed: "GameScene")
                gameScene?.scaleMode = .aspectFit
                let reveal = SKTransition.flipHorizontal(withDuration: 0)
                view?.presentScene(gameScene!, transition: reveal)
            }
        }
    }
}

