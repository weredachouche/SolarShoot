//
//  Sons.swift
//  Solar Shoot
//
//  Created by Mehir bitan on 17/04/2019.
//  Copyright © 2019 Lucas Abijmil. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

var sonsActivee = true

class Sons {
    
    //attributs
    public let bulletSound: SKAction
    public let explosionSound :SKAction
    public var sonsActivee : Bool

    init(sonsActivee: Bool){
         bulletSound = SKAction.playSoundFileNamed("Bulletsong.mp3", waitForCompletion: false)
        explosionSound = SKAction.playSoundFileNamed("Explosionsong.mp3", waitForCompletion: false)
        self.sonsActivee = sonsActivee
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func getBulletSound() -> SKAction{
        return bulletSound
    }
    public func getExplosionSound() -> SKAction{
        return explosionSound
    }
    public func getSonsActivee() -> Bool{
        return sonsActivee
    }
    
    public func setSonsActivee(valeur: Bool) {
        sonsActivee = valeur
    }
}
