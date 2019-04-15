//
//  GameScene.swift
//  Solar Shoot V1
//
//  Created by Lucas Abijmil on 19/02/2019.
//  Copyright © 2019 Lucas Abijmil. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
/*******************************************************************************************************************************************************************\
                                                            Declaration of general var
\******************************************************************************************************************************************************************/
    
    let planet = SKSpriteNode(imageNamed: "Planet")
    let background = SKSpriteNode(imageNamed: "Background")
    let bulletSound = SKAction.playSoundFileNamed("Bulletsong.mp3", waitForCompletion: false)
    //var pointLife = 3 Attendons la suite
    struct physicsCategories {
        static let none : UInt32 = 0
        static let planet : UInt32 = 0b1 // 1 en binaire
        static let bullet : UInt32 = 0b10 // 2 en binaire
        static let asteroid: UInt32 = 0b100 // 4 en binaire
    }
    var gameScore = 0
    let scoreLabel = SKLabelNode (fontNamed: "Starjedi")
    var lifePoint = 3
    var lifePointNode = SKSpriteNode (imageNamed: "Planet")
    var lifePointLabel = SKLabelNode (fontNamed: "Starjedi")
    //var lvlNumber = 0
    
    
/******************************************************************************************************************************************************************\
                                                         Declaration Game Area, Background, Planet
\******************************************************************************************************************************************************************/
    
    let gameArea : CGRect
    override init (size : CGSize) {
        let maxRatioAspect: CGFloat =  16.0 / 9.0
        let widthPlayable = size.height / maxRatioAspect
        let widthMargin =  (size.width - widthPlayable) / 2
        let heightPlayable = size.width / maxRatioAspect
        let heightMargin = (size.height - heightPlayable) / 1000
        gameArea = CGRect(x: widthMargin, y: heightMargin, width: widthPlayable, height: heightPlayable)
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        background.size = self.size
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = 0
        self.addChild(background)
        planet.setScale(0.55)
        planet.position = CGPoint(x: self.size.width / 2, y: self.size.height / 7)
        planet.zPosition = 2
        planet.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        planet.physicsBody = SKPhysicsBody(rectangleOf: planet.size) // déclaration du contouring de la planète
        planet.physicsBody!.affectedByGravity = false // on désactive la gravité pour la planète
        planet.physicsBody!.categoryBitMask = physicsCategories.planet
        planet.physicsBody!.collisionBitMask = physicsCategories.none
        planet.physicsBody!.contactTestBitMask = physicsCategories.asteroid
        scoreLabel.text = "score : 0"
        scoreLabel.fontSize = 60
        scoreLabel.fontColor = SKColor.white
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        scoreLabel.position = CGPoint(x: self.size.width * 0.15, y: self.size.height * 0.9)
        scoreLabel.zPosition = 100
        lifePointLabel.text = "vies : 3"
        lifePointLabel.fontSize = 60
        lifePointLabel.fontColor = SKColor.white
        lifePointLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        lifePointLabel.position = CGPoint(x: self.size.width * 0.85, y: self.size.height * 0.9)
        lifePointLabel.zPosition = 100
        self.addChild(lifePointLabel)
        self.addChild(scoreLabel)
        self.addChild(planet)
        newLevel()
        
    }
    
/******************************************************************************************************************************************************************\
                                                        Declaration Bullet, func FireBullet
\******************************************************************************************************************************************************************/
    
    
    func fireBullet () {
        let bullet = SKSpriteNode(imageNamed: "Bullet")
        bullet.setScale(0.5)
        bullet.position = CGPoint(x: planet.position.x, y: planet.position.y)
        bullet.zPosition = 1
        bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size)
        bullet.physicsBody!.affectedByGravity = false
        bullet.physicsBody!.categoryBitMask = physicsCategories.bullet
        bullet.physicsBody!.collisionBitMask = physicsCategories.none
        bullet.physicsBody!.contactTestBitMask = physicsCategories.asteroid
        self.addChild(bullet)
        let moveBullet = SKAction.moveTo(y: self.size.height + bullet.size.height, duration: 1.0)
        let deleteBullet = SKAction.removeFromParent()
        let bulletSequence = SKAction.sequence([bulletSound, moveBullet, deleteBullet])
        bullet.run(bulletSequence)
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
            if planet.position.y > gameArea.maxY - planet.size.height / 2  {
                planet.position.y = gameArea.maxY - planet.size.height / 2
            }
            if planet.position.y < gameArea.minY + planet.size.height / 2 {
                planet.position.y = gameArea.minY + planet.size.height / 2
            }
        }
    }
    
/******************************************************************************************************************************************************************\
                                                    Declaration of function random (for asteroids spawn)
\******************************************************************************************************************************************************************/
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF) //générer un nombre aléatoire
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
/******************************************************************************************************************************************************************\
                                                            Declaration of asteroids and new level
\******************************************************************************************************************************************************************/
    
    func newLevel(){
        /*lvlNumber += 1
         if self.action(forKey: "spawAsteroids") != nil {
            self.removeAction(forKey: "spawAsteroids")
        }
        var lvlDuration = TimeInterval()
        switch lvlNumber {
        case 1 : lvlDuration = 60
        case 2 : lvlDuration = 90
        case 3 : lvlDuration = 120
        default : print("Aucun niveau trouvé")
        } */
        let spawn = SKAction.run(asteroids)//Crée une action qui exécute un bloc, ici les asteroides
        let waitToSpawn = SKAction.wait(forDuration: 0.8)//Chaque seconde un nouvel asteroides tombe
        let spawnSequence = SKAction.sequence([waitToSpawn, spawn])//sequence:asteroides+attendre 1 sec
        let spawnForever = SKAction.repeatForever(spawnSequence)//Pour repeter la sequence
        self.run(spawnForever)
        //self.run (spawnForever, withKey: "spawAsteroids")//executer la sequence
    }
    
    func asteroids () {
        let asteroid = SKSpriteNode(imageNamed: "Asteroid")
        let randomStart = random(min:gameArea.minX, max:gameArea.maxX)
        let randomEnd = random(min:gameArea.minX, max:gameArea.maxX)
        let start = CGPoint(x: randomStart, y: self.size.height * 1.2)
        let end = CGPoint(x: randomEnd, y: -self.size.height)
        asteroid.setScale(0.2)
        asteroid.position = start
        asteroid.zPosition = 2
        asteroid.physicsBody = SKPhysicsBody(rectangleOf: asteroid.size)
        asteroid.physicsBody!.affectedByGravity = false
        asteroid.physicsBody!.categoryBitMask = physicsCategories.asteroid
        asteroid.physicsBody!.collisionBitMask = physicsCategories.none
        asteroid.physicsBody!.contactTestBitMask  = physicsCategories.planet | physicsCategories.bullet
        self.addChild(asteroid)
        let moveAsteroid = SKAction.move(to: end, duration: 5)
        let deleteAsteroid = SKAction.removeFromParent()
        //let loseALife = SKAction.run(losePointLife)
        //let asteroidSequence = SKAction.sequence([moveAsteroid,deleteAsteroid, loseALife])
        let asteroidSequence = SKAction.sequence([moveAsteroid, deleteAsteroid])
        asteroid.run(asteroidSequence)
        let dx = start.x - end.x
        let dy = start.y - end.y
        let amountToRotate = atan2(dy, dx)
        asteroid.zRotation = amountToRotate
    }
    
/******************************************************************************************************************************************************************\
                                                            Declaration of collisions & crash
\******************************************************************************************************************************************************************/
    func didBegin(_ contact: SKPhysicsContact) {
        var body1 = SKPhysicsBody()
        var body2 = SKPhysicsBody()
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            body1 = contact.bodyA
            body2 = contact.bodyB
        }
        else {
            body1 = contact.bodyB
            body2 = contact.bodyA
        }
        if body1.categoryBitMask == physicsCategories.planet && body2.categoryBitMask == physicsCategories.asteroid {
            //Si la planète touche un astéroïde
            losePointLife()
            if body1.node != nil {
                spawnExplosion(spawnPosition: body1.node!.position)
            }
            if body2.node != nil {
                spawnExplosion(spawnPosition : body2.node!.position)
            }
            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
        }
     
        if body1.categoryBitMask == physicsCategories.bullet && body2.categoryBitMask == physicsCategories.asteroid {
            //Si le missile touche un astéroïde
            addScore()
            if body2.node != nil{
                if body2.node!.position.y > self.size.height{
                    return //if the enemy is off the top of the screen, 'return'. This will stop running this code here, therefore doing nothing unless we hit the enemy when it's on the screen. As we are already checking that body2.node isn't nothing, we can safely unwrap (with '!)' this here.
                }
                else{
                    spawnExplosion(spawnPosition: body2.node!.position)
                }
            }
            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
        }
        
        
    }
    
    func spawnExplosion (spawnPosition : CGPoint) {
        let explosion = SKSpriteNode(imageNamed: "Explosion")
        explosion.position = spawnPosition
        explosion.zPosition = 3
        explosion.setScale(0.2)
        self.addChild(explosion)
        let scaleIn = SKAction.scale(to: 0.9, duration: 0.2)
        let fadeOut = SKAction.fadeOut(withDuration: 0.1)
        let deleteExplosion = SKAction.removeFromParent()
        let explosionSequence = SKAction.sequence([scaleIn, fadeOut, deleteExplosion])
        explosion.run(explosionSequence)
        
    }
    
/******************************************************************************************************************************************************************\
                                                                 Function AddScore
\******************************************************************************************************************************************************************/
    func addScore () {
        gameScore += 1
        scoreLabel.text = "score : \(gameScore)"
        
    }
    
/******************************************************************************************************************************************************************\
                                                                Function PointLife
\******************************************************************************************************************************************************************/
    func losePointLife () {
        lifePoint -= 1
        if lifePoint != 0 {
            lifePointLabel.text = "vies : \(lifePoint)"
        }
        if lifePoint == 0 {
            lifePointLabel.text = "vie : \(lifePoint)"
        }
        let scaleUp = SKAction.scale (to: 1.5, duration: 0.2)
        let scaleDown = SKAction.scale (to: 1, duration : 0.1)
        let changeColor = SKAction.colorize(with: UIColor.red, colorBlendFactor: 1, duration: 0)
        let returnColor = SKAction.colorize(with: UIColor.white, colorBlendFactor: 1, duration: 0)
        let scaleSequence = SKAction.sequence([changeColor,scaleUp, scaleDown, returnColor])
        lifePointLabel.run(scaleSequence)
    }
    
}

