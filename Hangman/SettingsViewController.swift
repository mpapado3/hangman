//
//  SettingsViewController.swift
//  Hangman
//
//  Created by Michael Papadopoulos on 24/8/16.
//  Copyright © 2016 Razzmatazz. All rights reserved.
//

import UIKit
import Parse

var kidsMode = false

class SettingsViewController: UIViewController {

    @IBOutlet weak var kidsModeSwitch: UISwitch!
    
    @IBAction func kidsModeSwitchAction(sender: AnyObject) {
        
        if kidsModeSwitch.on == false {
            kidsModeSwitch.on = false
            kidsMode = false
        } else {
            kidsModeSwitch.on = true
            kidsMode = true
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if kidsMode == false {
            kidsModeSwitch.on = false
        } else if kidsMode == true {
            kidsModeSwitch.on = true
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "disconnectSegue" {
            PFUser.logOut()
        }
    }

}
