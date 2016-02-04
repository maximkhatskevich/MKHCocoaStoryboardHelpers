//
//  UI.swift
//  MKHStoryboardHelpers
//
//  Created by Maxim Khatskevich on 2/4/16.
//  Copyright © 2016 Maxim Khatskevich. All rights reserved.
//

import UIKit

//===

enum UI: String //, SBHStoryboard
{
    // storyboards:
    
    case Main, Second
    
    //===
    
    // non-subclassed ViewControllers per storyboard:
    
    enum MainSB: String, SBHStoryboardVC
    {
        static var container: UI { return .Main }
        
        //===
        
        // non-subclassed ViewControllers:
        
        case NextVC
    }
    
    enum SecondSB: String, SBHStoryboardVC
    {
        static var container: UI { return .Second }
        
        //===
        
        // non-subclassed ViewControllers:
        
        case SomeVC
    }
}

//===

class BaseVC: UIViewController
{
    // MARK: IBActions
    
    @IBAction func showModalHandler(sender: AnyObject)
    {
        // for modal view controller we have custom UIViewController subclass
        // 'ModalVC', which also conforms to protocol 'SBHStoryboardIDInferable',
        // so we are allowed to infer desired storyboardID based on class name
        // and can use generic-based 'instantiateVC'
        
        let modalVC: ModalVC = UI.MainSB.instantiateVC()
        
        //===
        
        presentViewController(modalVC, animated: true, completion: nil)
    }
    
    @IBAction func showNextHandler(sender: AnyObject)
    {
        // for next view controller we do NOT have custom UIViewController subclass,
        // so we have to define desired storyboardID explicitly
        
        let nextVC = UI.MainSB.NextVC.instantiate()
        
        //===
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func showSomeHandler(sender: AnyObject)
    {
        // for some view controller we do NOT have custom UIViewController subclass as well,
        // so we have to define desired storyboardID explicitly
        
        let someVC = UI.SecondSB.SomeVC.instantiate()
        
        //===
        
        navigationController?.pushViewController(someVC, animated: true)
    }
}

//===

class ModalVC: UIViewController, SBHStoryboardIDInferable
{
    @IBAction func dismissHandler(sender: AnyObject)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
