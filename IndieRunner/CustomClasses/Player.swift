//
//  Player.swift
//  IndieRunner
//
//  Created by David Dvořák on 13.01.2024.
//

import SpriteKit

enum PlayerState {
    case idle, running
}

class Player: SKSpriteNode {
    
    var runFrames = [SKTexture]()
    var idleFrames = [SKTexture]()
    var jumpFrames = [SKTexture]()
    var dieFrame = [SKTexture]()
    
    var state = PlayerState.idle {
        willSet {
            animate(for: newValue)
        }
    }
    
    var airborne = false
    
    func loadTextures() {
        idleFrames = AnimationHelper.loadTextures(
            from: SKTextureAtlas(named: GameConstants.StringConstants.playerIdleAtlas),
            withName: GameConstants.StringConstants.idlePrefixKey
        )
        
        runFrames = AnimationHelper.loadTextures(
            from: SKTextureAtlas(named: GameConstants.StringConstants.playerRunAtlas),
            withName: GameConstants.StringConstants.runPrefixKey
        )
        
        jumpFrames = AnimationHelper.loadTextures(
            from: SKTextureAtlas(named: GameConstants.StringConstants.playerJumpAtlas),
            withName: GameConstants.StringConstants.jumpPrefixKey
        )
        
        dieFrame = AnimationHelper.loadTextures(
            from: SKTextureAtlas(named: GameConstants.StringConstants.playerDieAtlas),
            withName: GameConstants.StringConstants.diePrefixKey
        )
    }
    
    func animate(for state: PlayerState) {
        removeAllActions()
        switch state {
        case .idle:
            self.run(.repeatForever(.animate(
                with: idleFrames,
                timePerFrame: 0.05,
                resize: true,
                restore: true
            )))
        case .running:
            self.run(.repeatForever(.animate(
                with: runFrames,
                timePerFrame: 0.05,
                resize: true,
                restore: true
            )))
        }
    }
}
