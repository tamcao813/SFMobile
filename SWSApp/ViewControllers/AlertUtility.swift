//
//  AlertUtility.swift
//  SWSApp
//
//  Created by r.a.jantakal on 29/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

public typealias AlertAction = () -> Void

class AlertUtilities: NSObject {

    class func showAlertMessageWithTwoActionsAndHandler(_ errorTitle : String,errorMessage : String,errorAlertActionTitle : String ,errorAlertActionTitle2 : String?,viewControllerUsed : UIViewController, action1:@escaping AlertAction, action2:@escaping AlertAction){
        let alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle:UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: errorAlertActionTitle, style: UIAlertActionStyle.default, handler: { (action) in
            action1()
        }))
        if errorAlertActionTitle2 != nil {
            alert.addAction(UIAlertAction(title: errorAlertActionTitle2, style: UIAlertActionStyle.default, handler: { (action) in
                action2()
            }))
        }
        
        viewControllerUsed.present(alert, animated:true, completion: nil)
    }
    
    class func generateRandomIDForNewEntry()->String  {
        //  Make a variable equal to a random number....
        let randomNum:UInt32 = arc4random_uniform(99999999) // range is 0 to 99
        // convert the UInt32 to some other  types
        let someString:String = String(randomNum)
        print("number in notes is \(someString)")
        return someString
    }
    
}


