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

protocol SBHStoryboard { }

extension SBHStoryboard where
    Self: RawRepresentable /*expect enum*/,
    Self.RawValue == String /*expect enum based on String*/
{
    func instantiateVC<T: UIViewController where T: SBHStoryboardIDInferable>() -> T
    {
        let storyboard = UIStoryboard(name: self.rawValue, bundle: nil)
        let storyboardID = String(T)
        
        //===
        
        guard
            let result = storyboard.instantiateViewControllerWithIdentifier(storyboardID) as? T
        else
        {
            fatalError("Couldn't instantiate view controller with inferred identifier \(storyboardID)")
        }
        
        //===
        
        return result
    }
}

//===

protocol SBHStoryboardVC
{
    typealias StoryboardType
    
    static var container: StoryboardType { get }
}

extension SBHStoryboardVC where
    Self: RawRepresentable /*expect enum*/,
    Self.RawValue == String /*expect enum based on String*/,
    StoryboardType: RawRepresentable /*expect enum*/,
    StoryboardType.RawValue == String /*expect enum based on String*/
{
    func instantiate() -> UIViewController
    {
        let storyboard = UIStoryboard(name: Self.container.rawValue, bundle: nil)
        let storyboardID = self.rawValue
        let result = storyboard.instantiateViewControllerWithIdentifier(storyboardID)
        
        //===
        
        return result
    }
    
    static func instantiateVC<T: UIViewController where T: SBHStoryboardIDInferable>() -> T
    {
        let storyboard = UIStoryboard(name: Self.container.rawValue, bundle: nil)
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
        let storyboard = UIStoryboard(name: Self.container.rawValue, bundle: nil)
        
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
        let storyboard = UIStoryboard(name: Self.container.rawValue, bundle: nil)
        
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

////=== Initial "Objetive-C style" implementation
//
//protocol CSHName
//{
//    var csh_toString: String { get }
//}
//
//protocol CSHStoryboardName: CSHName { }
//
//protocol CSHStoryboardId: CSHName { }
//
//protocol CSHSegueId: CSHName { }
//
////===
//
//extension UIStoryboard
//{
//    // MARK: Convenience Initializers
//
//    convenience init(_ name: CSHStoryboardName, bundle: NSBundle? = nil)
//    {
//        self.init(name: name.csh_toString, bundle: bundle)
//    }
//
//    // MARK: View Controller Instantiation from Generics
//
//    func instantiateVC<T: UIViewController where T: CSHHasStoryboardId>() -> T
//    {
//        guard
//            let result = self.instantiateViewControllerWithIdentifier(T.csh_storyboardID) as? T
//            else
//        {
//            fatalError("Couldn't instantiate view controller with identifier \(T.csh_storyboardID)")
//        }
//
//        return result
//    }
//
//    func instantiateVC(storyboardId: CSHStoryboardId) -> UIViewController
//    {
//        return instantiateViewControllerWithIdentifier(storyboardId.csh_toString)
//    }
//}
