//
//  SecondViewController.swift
//  Hangman
//
//  Created by Michael Papadopoulos on 22/9/15.
//  Copyright © 2015 Razzmatazz. All rights reserved.
//

import UIKit


class TwoPlayerNetViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDelegate {
    
    var letterState = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    
    var letters = ["Α", "Β", "Γ", "Δ", "Ε", "Ζ", "Η", "Θ", "Ι", "Κ", "Λ", "Μ", "Ν", "Ξ", "Ο", "Π", "Ρ", "Σ", "Τ", "Υ", "Φ", "Χ", "Ψ", "Ω"]
    
    var letterActive = 0
    
    var wrongLetters : Int = 0
    
    var gameActive = true
    
    var count = 15
    
    var lettersFound: Int = 0
    
    var timer = NSTimer()
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var letterButton: UIButton!
    
    @IBOutlet weak var wordHidden: UILabel!
    
    
    @IBOutlet weak var hangerImage2: UIImageView!
    
    @IBOutlet weak var wordTitle: UILabel!
    
    
    @IBAction func letterButtonPressed(sender: AnyObject) {
        
        score = score + Int(Double(score) * Double(count) * 0.15)
        
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
                
                timer.invalidate()
                
                var query = PFQuery(className: "gameDetails")
                
                query.whereKey("userID", equalTo: (PFUser.currentUser()?.objectId)!)
                query.getFirstObjectInBackgroundWithBlock({ (gameScore: PFObject?, error: NSError?) in
                    if error != nil {
                        print("asldkeu fetching \(error!)")
                        let gameScore = PFObject(className: "gameDetails")
                        let acl = PFACL()
                        acl.publicReadAccess = true
                        acl.publicWriteAccess = true
                        gameScore.ACL = acl
                        gameScore["userID"] = (PFUser.currentUser()?.objectId)! as String
                        gameScore["gamesPlayed"] = 1
                        gameScore["games2PWon"] = 1
                        gameScore["score"] = score
                        gameScore.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) in
                            if success {
                                
                            } else {
                                print("asldkeu \(error!)")
                            }
                        })
                    } else if let gameScore = gameScore {
                        print("asldkeu gamesPlayed: \(gameScore["gamesPlayed"])")
                        print("asldkeu objectID: \(gameScore["objectId"])")
                        gameScore.incrementKey("gamesPlayed", byAmount: 1)
                        gameScore.incrementKey("games2PWon", byAmount: 1)
                        gameScore["score"] = gameScore["score"] as! Int + score
                        gameScore.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) in
                            if (success) {
                                
                            } else {
                                print("asldkeu saving Object \(error!)")
                            }
                        })
                    }
                    
                })
                
                
                performSegueWithIdentifier("resultSegue3", sender: nil)
                
                
            } else if wrongLetters == 6 {
                
                gameActive = false
                
                print("You Lose")
                
                label = "ΛΥΠΑΜΑΙ ΕΧΑΣΕΣ!"
                
                timer.invalidate()
                
                var query = PFQuery(className: "gameDetails")
                
                query.whereKey("userID", equalTo: (PFUser.currentUser()?.objectId)!)
                query.getFirstObjectInBackgroundWithBlock({ (gameScore: PFObject?, error: NSError?) in
                    if error != nil {
                        print("asldkeu fetching \(error!)")
                        let gameScore = PFObject(className: "gameDetails")
                        let acl = PFACL()
                        acl.publicReadAccess = true
                        acl.publicWriteAccess = true
                        gameScore.ACL = acl
                        gameScore["userID"] = (PFUser.currentUser()?.objectId)! as String
                        gameScore["gamesPlayed"] = 1
                        gameScore.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) in
                            if success {
                                
                            } else {
                                print("asldkeu \(error!)")
                            }
                        })
                    } else if let gameScore = gameScore {
                        print("asldkeu gamesPlayed: \(gameScore["gamesPlayed"])")
                        print("asldkeu objectID: \(gameScore["objectId"])")
                        gameScore.incrementKey("gamesPlayed", byAmount: 1)
                        gameScore.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) in
                            if (success) {
                                
                            } else {
                                print("asldkeu saving Object \(error!)")
                            }
                        })
                    }
                    
                })
                
                performSegueWithIdentifier("resultSegue3", sender: nil)
                
                
            }
            
            
            
        }
        
    }
    
    func timerUpdate() {
        
        timerLabel.text = String(count--)
        
        if count == -1 {
            
            timer.invalidate()
            
            count = 15
            
            wrongLetters += 1
            
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(OnePlayerViewController.timerUpdate), userInfo: nil, repeats: true)
            
            print(wrongLetters)
            
            if wrongLetters == 6 {
                
                gameActive = false
                
                print("You Lose")
                
                label = "ΛΥΠΑΜΑΙ ΕΧΑΣΕΣ!"
                
                timer.invalidate()
                
                var query = PFQuery(className: "gameDetails")
                
                query.whereKey("userID", equalTo: (PFUser.currentUser()?.objectId)!)
                query.getFirstObjectInBackgroundWithBlock({ (gameScore: PFObject?, error: NSError?) in
                    if error != nil {
                        print("asldkeu fetching \(error!)")
                        let gameScore = PFObject(className: "gameDetails")
                        let acl = PFACL()
                        acl.publicReadAccess = true
                        acl.publicWriteAccess = true
                        gameScore.ACL = acl
                        gameScore["userID"] = (PFUser.currentUser()?.objectId)! as String
                        gameScore["gamesPlayed"] = 1
                        gameScore.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) in
                            if success {
                                
                            } else {
                                print("asldkeu \(error!)")
                            }
                        })
                    } else if let gameScore = gameScore {
                        print("asldkeu gamesPlayed: \(gameScore["gamesPlayed"])")
                        print("asldkeu objectID: \(gameScore["objectId"])")
                        gameScore.incrementKey("gamesPlayed", byAmount: 1)
                        gameScore.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) in
                            if (success) {
                                
                            } else {
                                print("asldkeu saving Object \(error!)")
                            }
                        })
                    }
                    
                })
                
                
                performSegueWithIdentifier("resultSegue3", sender: self)
                
            }
            
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if activeWord != "" {

            let characters = Array(activeWord.characters)
        
            // print(characters)
        
            var i = 0
        
            for (i=0; i<characters.count; i+=1) {
            
                hiddenArray.append("_")
                wordToFind.append(String(characters[i]))
            
            }
        
            hiddenArray[0] = String(characters[0])
        
            hiddenArray[i-1] = String(characters.last)
        
            wordHidden.text = hiddenArray.joinWithSeparator(" ")
        
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(OnePlayerViewController.timerUpdate), userInfo: nil, repeats: true)
        } else {
            self.alertMessage("No Word", message: "No Word is chossen")
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
