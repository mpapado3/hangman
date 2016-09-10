//
//  WinViewController.swift
//  Hangman
//
//  Created by Michael Papadopoulos on 1/8/16.
//  Copyright © 2016 Razzmatazz. All rights reserved.
//

import UIKit

class WinViewController: UIViewController {
    
    @IBOutlet weak var looseMessageLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func playAgainButton(sender: AnyObject) {
        
        performSegueWithIdentifier("startAgainSegue", sender: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clearColor()
        view.opaque = false
        
        scoreLabel.text = "Πόντοι \(String(score))"
        
        if label != nil {
            looseMessageLabel.text = label
        }
        
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
