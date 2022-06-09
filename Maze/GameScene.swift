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
    var wallGroup = SKSpriteNode()
    var endOfMaze = SKSpriteNode()
    
    
    override func didMove(to view: SKView)
    {
        mazeNavi = childNode(withName: "mazeNavi") as! SKSpriteNode
        endOfMaze = childNode(withName: "endOfMaze") as! SKSpriteNode
        
        let borderBody = SKPhysicsBody(edgeLoopFrom:self.frame)
        borderBody.friction = 0
        
        self.physicsBody = borderBody
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        physicsWorld.contactDelegate = self
        
        var currentNum = 1
        
        for i in 1...4
        {
            var mazeWall = SKSpriteNode()
            mazeWall = childNode(withName: "mazeWall\(currentNum)") as! SKSpriteNode
            mazeWall.removeFromParent()
            mazeWall.physicsBody?.categoryBitMask = 2
            wallGroup.addChild(mazeWall)
            currentNum += 1
        }
        
        addChild(wallGroup)
        
        for node in wallGroup.children
        {
            node.physicsBody?.categoryBitMask = 2
        }
        mazeNavi.physicsBody?.categoryBitMask = 1
        wallGroup.physicsBody?.categoryBitMask = 2
        endOfMaze.physicsBody?.categoryBitMask = 3
//        wallGroup.physicsBody?.contactTestBitMask = 2
        mazeNavi.physicsBody?.contactTestBitMask = 2 | 3
       
    }
    
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        if contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 2
        {
            print("hit1")
//            mazeNavi.position = CGPoint(x: 371.041, y: 320)
        }
        if contact.bodyA.categoryBitMask == 2 && contact.bodyB.categoryBitMask == 1
        {
            print("hit2")
//            mazeNavi.position = CGPoint(x: 371.041, y: 320)
           
        }
        if contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 3
        {
            
        }
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
            if movableNode != nil
            {
                movableNode!.position = touch.location(in: self)
            }
            
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
