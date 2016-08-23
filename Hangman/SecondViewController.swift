//
//  SecondViewController.swift
//  Hangman
//
//  Created by Michael Papadopoulos on 22/9/15.
//  Copyright © 2015 Razzmatazz. All rights reserved.
//

import UIKit

extension Array {
    var last: Element {
        return self[self.endIndex - 1]
    }
}

class SecondViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDelegate {
    
    var letterState = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    
    var letters = ["Α", "Β", "Γ", "Δ", "Ε", "Ζ", "Η", "Θ", "Ι", "Κ", "Λ", "Μ", "Ν", "Ξ", "Ο", "Π", "Ρ", "Σ", "Τ", "Υ", "Φ", "Χ", "Ψ", "Ω"]
    
    var letterActive = 0
    
    var wrongLetters : Int = 0
    
    var gameActive = true
    
    var lettersFound: Int = 0

    @IBOutlet weak var letterButton: UIButton!
    
    @IBOutlet weak var wordHidden: UILabel!
    

    @IBOutlet weak var hangerImage2: UIImageView!
    
    @IBOutlet weak var wordTitle: UILabel!

    
    @IBAction func letterButtonPressed(sender: AnyObject) {
        
        var falseLetter: Bool = true
        
        if letterState[sender.tag - 1] == 1 && gameActive == true {
            
            letterState[sender.tag - 1] = letterActive

            sender.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
            
            let disableMyButton = sender as? UIButton
            disableMyButton!.enabled = false
            
            for i in 1..<wordToFind.count - 1 {
                if wordToFind[i] == letters[sender.tag - 1] {
                    // print(letters[sender.tag - 1])
                    hiddenArray[i] = letters[sender.tag - 1]
                    wordHidden.text = hiddenArray.joinWithSeparator(" ")
                    
                    lettersFound += 1
                    
                    falseLetter = false
                }
            }
            
            if falseLetter == true && wrongLetters < 6 {
                
                wrongLetters += 1
                
                print(wrongLetters)
                
                switch wrongLetters {
                case 1:
                    self.hangerImage2.image = UIImage(named: "head.png")
                case 2:
                    self.hangerImage2.image = UIImage(named: "body.png")
                case 3:
                    self.hangerImage2.image = UIImage(named: "left_hand.png")
                case 4:
                    self.hangerImage2.image = UIImage(named: "right_hand.png")
                case 5:
                    self.hangerImage2.image = UIImage(named: "left_leg.png")
                case 6:
                    self.hangerImage2.image = UIImage(named: "right_leg.png")
                default:
                    print("nothing")
                }
                
                
                
            }
            
            if lettersFound == wordToFind.count - 2 {
                
                gameActive = false
                
                print("You Won")
                
                label = "ΜΠΡΑΒΟ ΚΕΡΔΙΣΕΣ!"
                
                performSegueWithIdentifier("resultSegue2", sender: nil)
                
                
            } else if wrongLetters == 6 {
                
                gameActive = false
                
                print("You Lose")
                
                label = "ΛΥΠΑΜΑΙ ΕΧΑΣΕΣ!"
                
                /*
                 let winViewController = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                 let vController: UIViewController = winViewController.instantiateViewControllerWithIdentifier("WinViewController") as UIViewController
                 self.presentViewController(vController, animated: true, completion: nil)
                 */
                
                performSegueWithIdentifier("resultSegue2", sender: nil)
                
                /*
                 let winViewController = WinViewController()
                 winViewController.modalPresentationStyle = .OverCurrentContext
                 self.presentViewController(winViewController, animated: true, completion: nil)
                 */
                
            }

            
            
        }
        
    }
    

    /*
        sender.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        
        let disableMyButton = sender as? UIButton
        disableMyButton!.enabled = false
        */
        
    override func viewDidLoad() {
        super.viewDidLoad()

        wordHidden.text = hiddenArray.joinWithSeparator(" ")
        
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
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
