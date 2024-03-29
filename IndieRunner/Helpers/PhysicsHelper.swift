//
//  PhysicsHelper.swift
//  IndieRunner
//
//  Created by David Dvořák on 13.01.2024.
//

import SpriteKit

class PhysicsHelper {
    
    static func addPhysicsBody(to sprite: SKSpriteNode, with name: String) {
        switch name {
        case GameConstants.StringConstants.playerName:
            sprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(
                width: sprite.size.width/2,
                height: sprite.size.height
            ))
            sprite.physicsBody!.restitution = 0.0
            sprite.physicsBody!.allowsRotation = false
            sprite.physicsBody!.categoryBitMask = GameConstants.PhysicsCategories.playerCategory
            sprite.physicsBody!.collisionBitMask = GameConstants.PhysicsCategories.groundCategory
                | GameConstants.PhysicsCategories.finishCategory
            sprite.physicsBody!.contactTestBitMask = GameConstants.PhysicsCategories.allCategory
        default:
            sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
        }
    }
    
    
    static func addPhysicsBody(to tileMap: SKTileMapNode, and tileInfo: String) {
        let tileSize = tileMap.tileSize
        
        for row in 0..<tileMap.numberOfRows {
            var tiles: [Int] = []
            for col in 0..<tileMap.numberOfColumns {
                let tileDefinition = tileMap.tileDefinition(atColumn: col, row: row)
                let isUsedTile = tileDefinition?.userData?[tileInfo] as? Bool
                if isUsedTile ?? false {
                    tiles.append(1)
                } else {
                    tiles.append(0)
                }
            }
            if tiles.contains(1) {
                var platform = [Int]()
                for (index, tile) in tiles.enumerated() {
                    if tile == 1 && index < (tileMap.numberOfColumns - 1) {
                        platform.append(index)
                    } else if !platform.isEmpty {
                        let x = CGFloat(platform[0]) * tileSize.width
                        let y = CGFloat(row) * tileSize.height
                        
                        let tileNode = GroundNode(with: CGSize(
                            width: tileSize.width * CGFloat(platform.count),
                            height: tileSize.height
                        ))
                        tileNode.position = CGPoint(x: x, y: y)
                        tileNode.anchorPoint = .zero
                        tileMap.addChild(tileNode)
                        platform.removeAll()
                    }
                }
            }
        }
    }
}
