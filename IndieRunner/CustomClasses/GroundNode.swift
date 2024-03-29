//
//  GroundNode.swift
//  IndieRunner
//
//  Created by David Dvořák on 13.01.2024.
//

import SpriteKit

class GroundNode: SKSpriteNode {
    
    var isBodyActivated: Bool = false {
        didSet {  // property observer, block will be executed whenever value changes
            physicsBody = isBodyActivated ? activatedBody : nil
        }
    }
    
    private var activatedBody: SKPhysicsBody?
    
    init(with size: CGSize) {
        super.init(texture: nil, color: .clear, size: size)
        
        let bodyInitialPoint = CGPoint(x: .zero, y: size.height)
        let bodyEndPoint = CGPoint(x: size.width, y: size.height)
        
        activatedBody = SKPhysicsBody(edgeFrom: bodyInitialPoint, to: bodyEndPoint)
        activatedBody!.restitution = 0.0
        activatedBody!.categoryBitMask = GameConstants.PhysicsCategories.groundCategory
        activatedBody!.collisionBitMask = GameConstants.PhysicsCategories.playerCategory
        
        physicsBody = isBodyActivated ? activatedBody : nil
        
        name = GameConstants.StringConstants.groundNodeName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
