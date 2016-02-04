//
//  UI.swift
//  MKHStoryboardHelpers
//
//  Created by Maxim Khatskevich on 2/4/16.
//  Copyright © 2016 Maxim Khatskevich. All rights reserved.
//

import UIKit

//===

enum Storyboard // might be class or struct as well
{
    // Consider to name this type just "UI" (to make it shorter and nicer to use)
    // and use as UI objects factory, as UI router, etc.
    
    //===
    
    // storyboards:
    
    enum Main: String, SBHStoryboard
    {
        // non-subclassed ViewControllers:
        
        case NextVC
    }
    
    enum Second: String, SBHStoryboard
    {
        // non-subclassed ViewControllers:
        
        case SomeVC
    }
    
    enum Third: SBHStoryboard // might be class or struct as well
    {
        // this storyboard contains only initial VC,
        // so no need to define explicit IDs,
        // 
        // NOTE: this enum is should not declare a raw type,
        // until it has at least one case (explicit ID).
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
        
        let modalVC: ModalVC = Storyboard.Main.instantiateVC()
        
        //===
        
        presentViewController(modalVC, animated: true, completion: nil)
    }
    
    @IBAction func showNextHandler(sender: AnyObject)
    {
        // for next view controller we do NOT have custom UIViewController subclass,
        // so we have to define desired storyboardID explicitly
        
        let nextVC = Storyboard.Main.NextVC.instantiate()
        
        //===
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func showSomeHandler(sender: AnyObject)
    {
        // for some view controller we do NOT have custom UIViewController subclass as well,
        // so we have to define desired storyboardID explicitly
        
        let someVC = Storyboard.Second.SomeVC.instantiate()
        
        //===
        
        navigationController?.pushViewController(someVC, animated: true)
    }
    
    @IBAction func showThirdSBInitialHandler(sender: AnyObject)
    {
        // in Third storyboard we do not have explicit storyboardIDs or
        // custom UIViewController subclasses assigned to view controllers,
        // we only have initial view controller there
        
        let thirdInitialVC = Storyboard.Third.instantiateInitialVC()
        
        //===
        
        navigationController?.pushViewController(thirdInitialVC, animated: true)
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
