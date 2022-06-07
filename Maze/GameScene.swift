//
//  GameScene.swift
//  Maze
//
//  Created by  on 6/7/22.
//

import SpriteKit
import GameplayKit



class GameScene: SKScene
{
    var movableNode : SKNode?
    var mazeNavi = SKSpriteNode()
    
    
    override func didMove(to view: SKView)
    {
        mazeNavi = childNode(withName: "mazeNavi") as! SKSpriteNode
    }
    
    
}
