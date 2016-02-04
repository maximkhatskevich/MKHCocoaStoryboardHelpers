//
//  SBHMain.swift
//  MKHStoryboardHelpers
//
//  Created by Maxim Khatskevich on 2/4/16.
//  Copyright © 2016 Maxim Khatskevich. All rights reserved.
//
//  Inspired by:
//  
//  - UIStoryboard: Safer with Enums, Protocol Extensions and Generics
//    https://medium.com/swift-programming/uistoryboard-safer-with-enums-protocol-extensions-and-generics-7aad3883b44d#.ok5f87u7s
//
//  - Advanced & Practical Enum usage in Swift
//    http://appventure.me/2015/10/17/advanced-practical-enum-examples/
//
//  - Protocols with Associated Types
//    https://www.natashatherobot.com/swift-protocols-with-associated-types/
//
//  - Protocol-Oriented Segue Identifiers
//    https://www.natashatherobot.com/protocol-oriented-segue-identifiers-swift/
//


import UIKit

//===

protocol SBHStoryboardIDInferable { }

//===

protocol SBHStoryboardVC { }

extension SBHStoryboardVC where
    Self: RawRepresentable /*expect enum*/,
    Self.RawValue == String /*expect enum based on String*/
{
    func instantiate() -> UIViewController
    {
        let storyboard = UIStoryboard(name: String(Self), bundle: nil)
        let storyboardID = self.rawValue
        let result = storyboard.instantiateViewControllerWithIdentifier(storyboardID)
        
        //===
        
        return result
    }
}

extension SBHStoryboardVC
{
    static func instantiateVC<T: UIViewController where T: SBHStoryboardIDInferable>() -> T
    {
        let storyboard = UIStoryboard(name: String(Self), bundle: nil)
        let storyboardID = String(T)
        
        //===
        
        guard
            let result = storyboard.instantiateViewControllerWithIdentifier(storyboardID) as? T
            else
        {
            fatalError("Couldn't instantiate view controller with inferred identifier \(storyboardID).")
        }
        
        //===
        
        return result
    }
    
    static func instantiateInitialVC<T: UIViewController where T: SBHStoryboardIDInferable>() -> T
    {
        let storyboard = UIStoryboard(name: String(Self), bundle: nil)
        
        //===
        
        guard
            let result = storyboard.instantiateInitialViewController() as? T
            else
        {
            fatalError("Couldn't instantiate initial view controller of inferred class \(String(T)).")
        }
        
        //===
        
        return result
    }
    
    static func instantiateInitialVC() -> UIViewController
    {
        let storyboard = UIStoryboard(name: String(Self), bundle: nil)
        
        //===
        
        guard
            let result = storyboard.instantiateInitialViewController()
            else
        {
            fatalError("Couldn't instantiate initial view controller.")
        }
        
        //===
        
        return result
    }
}
