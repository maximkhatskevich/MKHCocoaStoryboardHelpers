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
        
        //===
        
        // Here declare segues that are available
        // inside this ("Third") storyboard,
        // but defined inside non-subclassed VC.
        //
        // NOTE: the name of the type doesn't matter in this case.
        
        enum SegueID: String, SBHStoryboardSegue
        {
            case AnotherSegue
        }
        
        // NOTE: you can group segue declarations
        // into several separate types, it works too,
        // just make sure every type conforms to 'SBHStoryboardSegue'
    }
}

//===

class BaseVC: UIViewController, SBHStoryboardVC
{
    // MARK: Segue definition
    
    enum SegueID: String, SBHStoryboardSegue
    {
        case TheOneSegue
    }
    
    // MARK: IBActions
    
    @IBAction func showModalHandler(_ sender: AnyObject)
    {
        // for modal view controller we have custom UIViewController subclass
        // 'ModalVC', which also conforms to protocol 'SBHStoryboardIDInferable',
        // so we are allowed to infer desired storyboardID based on class name
        // and can use generic-based 'instantiateVC'
        
        let modalVC: ModalVC = Storyboard.Main.instantiateVC()
        
        //===
        
        present(modalVC, animated: true, completion: nil)
    }
    
    @IBAction func showNextHandler(_ sender: AnyObject)
    {
        // for next view controller we do NOT have custom UIViewController subclass,
        // so we have to define desired storyboardID explicitly
        
        let nextVC = Storyboard.Main.NextVC.instantiate()
        
        //===
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func showSomeHandler(_ sender: AnyObject)
    {
        // for some view controller we do NOT have custom UIViewController subclass as well,
        // so we have to define desired storyboardID explicitly
        
        let someVC = Storyboard.Second.SomeVC.instantiate()
        
        //===
        
        navigationController?.pushViewController(someVC, animated: true)
    }
    
    @IBAction func showThirdSBInitialHandler(_ sender: AnyObject)
    {
        // in Third storyboard we do not have explicit storyboardIDs or
        // custom UIViewController subclasses assigned to view controllers,
        // we only have initial view controller there
        
        let thirdInitialVC = Storyboard.Third.instantiateInitialVC()
        
        //===
        
        navigationController?.pushViewController(thirdInitialVC, animated: true)
        
        //===
        
        // lets push another VC right away,
        // be sure to pass correct VC:
        
        Storyboard.Third.SegueID.AnotherSegue.perform(from: thirdInitialVC, sender: nil)
    }
    
    @IBAction func callSegueHandler(_ sender: AnyObject)
    {
        performSegue(.TheOneSegue, sender: sender)
        
        //===
        
        // // alternative way to do the same,
        // // when you call it outside of custom VC:
        //
        // let aVC = self
        // SegueID.TheOneSegue.perform(aVC, sender: sender)
    }
    
    // MARK: Overrided methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        switch SegueID(from: segue)
        {
            case .TheOneSegue:
                print("Segue with ID 'TheOneSegue' will be performed!")
        }
    }
}

//===

class ModalVC: UIViewController, SBHStoryboardIDInferable
{
    @IBAction func dismissHandler(_ sender: AnyObject)
    {
        dismiss(animated: true, completion: nil)
    }
}
