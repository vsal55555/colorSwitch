//
//  Settings.swift
//  colorSwitch
//
//  Created by BSAL-MAC on 5/6/20.
//  Copyright © 2020 BSAL-MAC. All rights reserved.
//

import SpriteKit

enum PhysicsCategories{
    static let none: UInt32 = 0
    static let ballCategory: UInt32 = 0x1 //    01
    static let switchCategory: UInt32 = 0x1 << 10 //bitwise shift opearator shift all my bits to my left
    
}
enum ZPosition {
    static let label: CGFloat = 0
    static let ball: CGFloat = 1
    static let colorSwitch: CGFloat = 2
    
}
