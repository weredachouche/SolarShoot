//
//  GameScene.swift
//  Solar Shoot V1
//
//  Created by Lucas Abijmil on 19/02/2019.
//  Copyright © 2019 Lucas Abijmil. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    
/******************************************************************************************************************************************************************\
                                                                Declaration of general var
\******************************************************************************************************************************************************************/
    let planet = SKSpriteNode(imageNamed: "Planet")
    let background = SKSpriteNode(imageNamed: "Background")
    let maxLineY = SKSpriteNode(imageNamed: "Max_y_line")
    
/******************************************************************************************************************************************************************\
                                                            Declaraiton Game Area, Background, Planet
\******************************************************************************************************************************************************************/
    let gameArea : CGRect
    override init (size : CGSize) {
        let maxRatioAspect: CGFloat =  16.0 / 9.0
        let widthPlayable = size.height / maxRatioAspect
        let widthMargin =  (size.width - widthPlayable) / 2
        let heightPlayable = size.width / maxRatioAspect
        let heightMargin = (size.height - heightPlayable) / 5
        gameArea = CGRect(x: widthMargin, y: heightMargin, width: widthPlayable, height: )
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        background.size = self.size
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = 0
        self.addChild(background)
        planet.setScale(0.55)
        planet.position = CGPoint(x: self.size.width / 2, y: self.size.height / 7)
        planet.zPosition = 2
        planet.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.addChild(planet)
    }
    
/******************************************************************************************************************************************************************\
                                                        Declaration Bullet, func FireBullet
\******************************************************************************************************************************************************************/
    func fireBullet () {
        let bullet = SKSpriteNode(imageNamed: "Bullet")
        bullet.setScale(0.5)
        bullet.position = CGPoint(x: planet.position.x, y: planet.position.y)
        bullet.zPosition = 1
        self.addChild(bullet)
        let moveBullet = SKAction.moveTo(y: self.size.height + bullet.size.height, duration: 1.0)
        let deleteBullet = SKAction.removeFromParent()
        let sequenceBullet = SKAction.sequence([moveBullet, deleteBullet])
        bullet.run(sequenceBullet)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        fireBullet()
    }
    
/******************************************************************************************************************************************************************\
                                                                    Move Planet
\******************************************************************************************************************************************************************/
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch : AnyObject in touches {
            let pointOfTouch = touch.location(in: self)
            let previousPointOfTouch = touch.previousLocation(in: self)
            
            let amountDraggedX = pointOfTouch.x - previousPointOfTouch.x
            let amountDraggedY = pointOfTouch.y - previousPointOfTouch.y
            
            planet.position.x += amountDraggedX
            planet.position.y += amountDraggedY
            
            if planet.position.x > gameArea.maxX - planet.size.width / 2 {
                planet.position.x = gameArea.maxX - planet.size.width / 2
            }
            if planet.position.x < gameArea.minX + planet.size.width / 2 {
                planet.position.x = gameArea.minX + planet.size.width / 2
            }
            if planet.position.y > gameArea.maxY - planet.size.height {
                planet.position.y = gameArea.maxY - planet.size.height
            }
            if planet.position.y < gameArea.minY + planet.size.height {
                planet.position.y = gameArea.minY + planet.size.height
            }
        }
    }
}

