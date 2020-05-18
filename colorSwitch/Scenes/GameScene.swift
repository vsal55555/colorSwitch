//
//  GameScene.swift
//  colorSwitch
//
//  Created by BSAL-MAC on 5/5/20.
//  Copyright © 2020 BSAL-MAC. All rights reserved.
//

import SpriteKit

enum PlayColors{
    static let colors = [
    UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1),
    UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1),
    UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1),
    UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1)
    ]
}
//we will add our second enumerationsfor the state of the color
enum SwitchState: Int {
    //case yellow, red, blue, green
    case red, yellow, green, blue
}

class GameScene: SKScene {
    
    var colorSwitch: SKSpriteNode!
    
    var switchState = SwitchState.red //inital state
    var currentColorIndex: Int? //lateron
    
    let scoreLabel = SKLabelNode(text: "0")
    var score = 0
    
    override func didMove(to view: SKView) {
        setupPhysics()
        layoutScene()
        // Get label node from scene and store it for use later
        //to actually register your occuring physics contacts in our game we will us existing protocol i.e contact delegate of the physics world
    }
    
    func setupPhysics(){
        //specifying the gravity in x and y direction
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -0.25)
        physicsWorld.contactDelegate = self //we need to conform class gamescene with this protocol. For that lets create extension of game scene
    }
    
    func layoutScene(){
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        colorSwitch = SKSpriteNode(imageNamed: "ColorCircle")
        //since colorswitch is circle so same same width and height
        colorSwitch.size = CGSize(width: frame.size.width/3, height: frame.size.width/3)
        //lets begin to adjust the position of colorswitch
        colorSwitch.position = CGPoint(x: frame.midX, y: frame.minY + colorSwitch.size.height)
        colorSwitch.zPosition = ZPosition.colorSwitch
        colorSwitch.physicsBody = SKPhysicsBody(circleOfRadius: colorSwitch.size.width/2)
        colorSwitch.physicsBody?.categoryBitMask = PhysicsCategories.switchCategory
        colorSwitch.physicsBody?.isDynamic = false
        addChild(colorSwitch)
        scoreLabel.fontName = "Avenir"
        scoreLabel.fontSize = 60.0
        scoreLabel.color = UIColor.white
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        scoreLabel.zPosition = ZPosition.label
        addChild(scoreLabel)
        spawnBall()
    }
    func updateScoreLabel(){
        scoreLabel.text = "\(score)"
    }
    func spawnBall(){
        currentColorIndex = Int(arc4random_uniform(UInt32(4))) //it'll create random number between 0 and 3. Also don't forget to cast
        let ball = SKSpriteNode(texture: SKTexture(imageNamed: "ball"), color: PlayColors.colors[currentColorIndex!], size:CGSize(width: 30.0, height: 30.0))//actually colors our texture with random color from our playcolor array
        ball.colorBlendFactor = 1.0 //this makes sure that the color is actually applied to my texture since the default value is 0.
        ball.name = "Ball"
        ball.position = CGPoint(x: frame.midX, y: frame.maxY)
        ball.zPosition = ZPosition.ball
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
        ball.physicsBody?.categoryBitMask = PhysicsCategories.ballCategory
        ball.physicsBody?.contactTestBitMask = PhysicsCategories.switchCategory
        ball.physicsBody?.collisionBitMask = PhysicsCategories.none
        addChild(ball)
        
        
    }
    //we do wanna call this method each time the user taps the screen
    func turnWheel() {
        if let newState = SwitchState(rawValue: switchState.rawValue + 1){
            switchState = newState  //reset the value to 0 if found 4 (1,2,3)
        }
        else{
                //first case in enumeration
            switchState = .red
        }
        colorSwitch.run(SKAction.rotate(byAngle: .pi/2, duration: 0.25))
    }
    
    func gameOver(){
        //save highscore in user default
        UserDefaults.standard.set(score, forKey: "RecentScore")
        if score > UserDefaults.standard.integer(forKey: "HighScore"){   //score>0
                UserDefaults.standard.set(score, forKey: "HighScore")
        
        }
        // print("GameOver!") //to check if our game logic actually works
        let menuScene = MenuScene(size: view!.bounds.size)
        view!.presentScene(menuScene)
    }
    //this method always gets call when a tap is registered on the screen.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        turnWheel()
    }
}

extension GameScene: SKPhysicsContactDelegate{
    //we still want to implement one method of the protocol here
    func didBegin(_ contact: SKPhysicsContact) {
        // is called whenever a contact is registered in our scene
        //we can use now bitmask to determine what kind of contact has happened
        //in our game we pretty much have one possible contact but in complex game there might be more possible contact
        //01
        //10
        //11
        let contactmask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask // to combine two bodies
        if contactmask == PhysicsCategories.ballCategory | PhysicsCategories.switchCategory{
           // print("contact happened")
            //checking which node is ball then assign to constant ball
            if let ball = contact.bodyA.node?.name == "Ball" ? contact.bodyA.node as? SKSpriteNode : contact.bodyB.node as? SKSpriteNode {
                if currentColorIndex == switchState.rawValue{
                    //print("Correct!")
                    //play sound
                    //run(SKAction.playSoundFileNamed("bling", waitForCompletion: false))
                    score += 1 //actual logic right color matching
                    updateScoreLabel()
                    ball.run(SKAction.fadeOut(withDuration: 0.25), completion:  {
                        ball.removeFromParent()
                        self.spawnBall()
                    })
                    
                }else{
                    gameOver()
                }
            }
            
        }
    }
}

