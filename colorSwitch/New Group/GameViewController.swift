//
//  GameViewController.swift
//  colorSwitch
//
//  Created by BSAL-MAC on 5/5/20.
//  Copyright © 2020 BSAL-MAC. All rights reserved.
//

import UIKit
import SpriteKit


class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //this view controller is being used as skview able to render sprite kit content
        if let view = self.view as! SKView? {
            //we initailize the game scene class that will load entire view so that we can add our elements to the scene and they will fit the entire screen.
            let scene = MenuScene(size: view.bounds.size)
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene which makes sure that our view is showing our scene.
                view.presentScene(scene)
            
            
            view.ignoresSiblingOrder = true
            //debug info
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    
}
