//
//  Level.swift
//  Solar Shoot
//
//  Created by Hanna on 10/04/2019.
//  Copyright © 2019 Lucas Abijmil. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

/*class Level:SKScene{
    
    //Pour avoir accès aux fonctions de la gameScene
    var gameScene = GameScene()

    //On déclare toutes les planètes en fonctions des niveaux
    public var planet = Planet(imageName: "Planet")
    public var planetIcon = PlanetLife(image: "Planet")

    private var planetLvlI = PlanetLife(image: "Mercure")
    private var planetLvl1 = Planet(imageName: "Mercure")

    private var planetLvlII = PlanetLife(image: "Venus")
    private var planetLvl2 = Planet(imageName: "Venus")

    private var planetLvlIII = PlanetLife(image: "Terre")
    private var planetLvl3 = Planet(imageName: "Terre")

    private var planetLvlIV = PlanetLife(image: "Mars")
    private var planetLvl4 = Planet(imageName: "Mars")

    private var planetLvlV = PlanetLife(image: "Jupiter")
    private var planetLvl5 = Planet(imageName: "Jupiter")

    private var planetLvlVI = PlanetLife(image: "Saturne")
    private var planetLvl6 = Planet(imageName: "Saturne")

    private var planetLvlVII = PlanetLife(image: "Uranus")
    private var planetLvl7 = Planet(imageName: "Uranus")

    private var planetLvlVIII = PlanetLife(image: "Neptune")
    private var planetLvl8 = Planet(imageName: "Neptune")

    override init (size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    for i in 0...1 {
    func AffichageBack(background:SKSpriteNode){
    background.size = self.size
    background.anchorPoint = CGPoint(x: 0.5, y: 0)
    background.position = CGPoint(x: self.size.width / 2,
    y: self.size.height * CGFloat(i))
    background.zPosition = 0
    background.name = "Background"
    self.addChild(background)
    }
    switch lvlSelected {
    case 1 :
    let background = SKSpriteNode(imageNamed: "Fond_Mercure")
    AffichageBack(background: background)
    break
    case 2 :
    let background = SKSpriteNode(imageNamed: "Fond_Venus")
    AffichageBack(background: background)
    break
    case 3 :
    let background = SKSpriteNode(imageNamed: "Fond_Terre")
    AffichageBack(background: background)
    break
    case 4 :
    let background = SKSpriteNode(imageNamed: "Fond_Mars")
    AffichageBack(background: background)
    break
    case 5 :
    let background = SKSpriteNode(imageNamed: "Fond_Jupiter")
    AffichageBack(background: background)
    break
    case 6 :
    let background = SKSpriteNode(imageNamed: "Fond_Saturne")
    AffichageBack(background: background)
    break
    case 7 :
    let background = SKSpriteNode(imageNamed: "Fond_Uranus")
    AffichageBack(background: background)
    break
    case 8 :
    let background = SKSpriteNode(imageNamed: "Fond_Neptune")
    AffichageBack(background: background)
    break
    default:
    let background = SKSpriteNode(imageNamed: "Carte")
    AffichageBack(background: background)
    break
    
    }
    }
    func LevelCaracteristic(){
        switch lvlSelected {
        case 1 :
            gameScene.Level(x:6, eparpillement: 0.6)
            break
        case 2 :
            gameScene.Level(x:800, eparpillement: 0.55)
            break
        case 3 :
            gameScene.Level(x:1000, eparpillement: 0.50)
            break
        case 4 :
            gameScene.Level(x:1200, eparpillement: 0.45)
            break
        case 5 :
            gameScene.Level(x:1400, eparpillement: 0.40)
            break
        case 6 :
            gameScene.Level(x:1600, eparpillement: 0.35)
            break
        case 7 :
            gameScene.Level(x:1800, eparpillement: 0.30)
            break
        case 8 :
            gameScene.Level(x:2000, eparpillement: 0.20)
            break
        default :
            planet.addPlanet(parent: self)
            planet.phys()
            planetIcon.addPlanet(parent: self)
            break
        }
    }
}
*/
