//
//  menuScene.swift
//  colorSwitch
//
//  Created by BSAL-MAC on 5/7/20.
//  Copyright © 2020 BSAL-MAC. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        addLogo()
        addLabels()
    }
    func addLogo(){
        let logo = SKSpriteNode(imageNamed: "logo")
        logo.size = CGSize(width: frame.size.width/4, height: frame.size.width/4) //resize logo
        logo.position = CGPoint(x: frame.midX, y: frame.midY + frame.size.height/4)
        addChild(logo)
    }
    func addLabels(){
        let playLabel = SKLabelNode(text: "Tap to Play!")
        playLabel.fontName = "Avenir"
        playLabel.fontSize = 50.0
        playLabel.fontColor = UIColor.white
        playLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(playLabel)
        animate(label: playLabel)
        
        let highscoreLabel = SKLabelNode(text: "Highscore: " + "\(UserDefaults.standard.integer(forKey: "HighScore"))")
        highscoreLabel.fontName = "Avenir"
        highscoreLabel.fontSize = 40.0
        highscoreLabel.fontColor = UIColor.white
        highscoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - highscoreLabel.frame.size.height*4)
        addChild(highscoreLabel)
        
        let recentscoreLabel = SKLabelNode(text: "Recent Score" + "\(UserDefaults.standard.integer(forKey: "RecentScore"))")
        recentscoreLabel.fontName = "Avenir"
        recentscoreLabel.fontSize = 40.0
        recentscoreLabel.fontColor = UIColor.white
        recentscoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - recentscoreLabel.frame.size.height*2)
        addChild(recentscoreLabel)
        
    }
    func animate(label: SKLabelNode){
       let fadeOut = SKAction.fadeOut(withDuration: 0.5)
       let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        
        //let scaleUp = SKAction.scale(by: 1.1, duration: 0.5)
        //let scaleDown = SKAction.scale(by: 1.0, duration: 0.5)
        
        let sequence = SKAction.sequence([fadeOut,fadeIn])
        label.run(SKAction.repeatForever(sequence))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScene = GameScene(size: view!.bounds.size)
        view!.presentScene(gameScene)
    }
}
