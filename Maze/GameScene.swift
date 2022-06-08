//
//  GameScene.swift
//  Maze
//
//  Created by  on 6/7/22.
//

import SpriteKit
import GameplayKit



class GameScene: SKScene, SKPhysicsContactDelegate
{
    var movableNode : SKNode?
    var mazeNavi = SKSpriteNode()
    
    
    override func didMove(to view: SKView)
    {
        mazeNavi = childNode(withName: "mazeNavi") as! SKSpriteNode
        
        let borderBody = SKPhysicsBody(edgeLoopFrom:self.frame)
        borderBody.friction = 0
        
        self.physicsBody = borderBody
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        physicsWorld.contactDelegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if let touch = touches.first
        {
            let location = touch.location(in: self)
            if mazeNavi.contains(location)
            {
                movableNode = mazeNavi
                movableNode!.position = location
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if let touch = touches.first, movableNode != nil
        {
            movableNode!.position = touch.location(in: self)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if let touch = touches.first, movableNode != nil
        {
            movableNode!.position = CGPoint(x: 371.041, y: 320 )
            movableNode = nil
        }
    }
    
}
