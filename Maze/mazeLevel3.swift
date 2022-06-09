//
//  mazeLevel3.swift
//  Maze
//
//  Created by  on 6/9/22.
//

import Foundation
import SpriteKit
import GameplayKit



class mazeLevel3: SKScene, SKPhysicsContactDelegate
{
    var movableNode : SKNode?
    var mazeNavi = SKSpriteNode()
    var wallGroup = SKSpriteNode()
    var endOfMaze = SKSpriteNode()
    
    var canMove = false
    
    
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
        
        for i in 1...6
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
            canMove = false
            let moveNavi = SKAction.move(to: CGPoint(x: 240, y: 191) , duration: 0)
            mazeNavi.run(moveNavi)
        }
        if contact.bodyA.categoryBitMask == 2 && contact.bodyB.categoryBitMask == 1
        {
            print("hit2")
//            mazeNavi.position = CGPoint(x: 371.041, y: 320)
            canMove = false
            let moveNavi = SKAction.move(to: CGPoint(x: 240, y: 191) , duration: 0)
            mazeNavi.run(moveNavi)

        }
        if contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 3
        {
            let mazelevel2 = mazeLevel2(fileNamed: "mazeLevel2")
            mazelevel2?.scaleMode = .aspectFit
            let reveal = SKTransition.flipHorizontal(withDuration: 0)
            view?.presentScene(mazelevel2!, transition: reveal)
        }
        if contact.bodyA.categoryBitMask == 3 && contact.bodyB.categoryBitMask == 1
        {
            let mazelevel2 = mazeLevel2(fileNamed: "mazeLevel2")
            mazelevel2?.scaleMode = .aspectFit
            let reveal = SKTransition.flipHorizontal(withDuration: 0)
            view?.presentScene(mazelevel2!, transition: reveal)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if let touch = touches.first
        {
            let location = touch.location(in: self)
            if mazeNavi.contains(location)
            {
                canMove = true
                movableNode = mazeNavi
                movableNode!.position = location
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if let touch = touches.first, movableNode != nil
        {
            if movableNode != nil && canMove == true
            {
                movableNode!.position = touch.location(in: self)
            }
            
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        canMove = false
        if let touch = touches.first, movableNode != nil
        {
            movableNode!.position = CGPoint(x: 240, y: 191 )
            movableNode = nil
        }
    }
    
    
}
