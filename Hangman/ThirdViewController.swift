//
//  ThirdViewController.swift
//  Hangman
//
//  Created by Michael Papadopoulos on 3/10/15.
//  Copyright © 2015 Razzmatazz. All rights reserved.
//

import UIKit

var label: String!

class ThirdViewController: UIViewController {
    
    var letterState = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    
    var letters = ["Α", "Β", "Γ", "Δ", "Ε", "Ζ", "Η", "Θ", "Ι", "Κ", "Λ", "Μ", "Ν", "Ξ", "Ο", "Π", "Ρ", "Σ", "Τ", "Υ", "Φ", "Χ", "Ψ", "Ω"]
    
    var letterActive = 0
    
    var wrongLetters : Int = 0
    
    var gameActive = true
    
    var lettersFound: Int = 0
    
    var hiddenArray = [String]()
    
    var wordToFind = [String]()
    
    var characterCount: Int = 0
    
    var count = 15
    
    var timer = NSTimer()

    @IBOutlet weak var wordHidden: UILabel!
    
    @IBOutlet weak var letterButton: UIButton!
    
    @IBOutlet weak var hangerImage: UIImageView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let path = NSBundle.mainBundle().pathForResource("words", ofType: "ini"){
            do {
                let stringFromFile = try String(contentsOfFile:path, encoding: NSUTF8StringEncoding)
                var words: [String] = stringFromFile.componentsSeparatedByString("\n")
                
                var activeWordNumber = Int(arc4random_uniform(UInt32(words.count)))
                
                var activeWord = words[activeWordNumber]
                
                var characters = Array(activeWord.characters)
                
                print("word: \(activeWord) Letters: \(characters.count)")
                
                while characters.count > 12 {
                    
                    activeWordNumber = Int(arc4random_uniform(UInt32(words.count)))
                
                    activeWord = words[activeWordNumber]
                
                    characters = Array(activeWord.characters)
                    
                    print("word: \(activeWord) Letters: \(characters.count)")
                    
                }
                
                var i = 0
                
                for (i = 0; i<characters.count ; i += 1) {
                    
                    hiddenArray.append("_")
                    wordToFind.append(String(characters[i]))
                    
                }
                
                hiddenArray[0] = String(characters[0])
                
                hiddenArray[i-1] = String(characters.last)
                
                wordHidden.text = hiddenArray.joinWithSeparator(" ")
                
            } catch {
                print((error))
            }
            
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ThirdViewController.timerUpdate), userInfo: nil, repeats: true)
            
        }

        // Do any additional setup after loading the view.
        
    }
    
    func timerUpdate() {
        
        timerLabel.text = String(count--)
        
        if count == -1 {
            
            timer.invalidate()
            
            count = 15
            
            wrongLetters += 1
            
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ThirdViewController.timerUpdate), userInfo: nil, repeats: true)
             
            print(wrongLetters)
            
            if wrongLetters == 6 {
                
                gameActive = false
                
                print("You Lose")
                
                label = "ΛΥΠΑΜΑΙ ΕΧΑΣΕΣ!"
                
                performSegueWithIdentifier("resultSegue", sender: nil)
                
            }
             
            switch wrongLetters {
            case 1:
            self.hangerImage.image = UIImage(named: "head.png")
            case 2:
            self.hangerImage.image = UIImage(named: "body.png")
            case 3:
            self.hangerImage.image = UIImage(named: "left_hand.png")
            case 4:
            self.hangerImage.image = UIImage(named: "right_hand.png")
            case 5:
            self.hangerImage.image = UIImage(named: "left_leg.png")
            case 6:
            self.hangerImage.image = UIImage(named: "right_leg.png")
            default:
            print("nothing")

            }
            
        }
    }

    @IBAction func letterButtonPressed(sender: AnyObject) {
        
        count = 15
        
        timer.invalidate()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ThirdViewController.timerUpdate), userInfo: nil, repeats: true)
        
        var falseLetter: Bool = true
        
        if letterState[sender.tag - 1] == 1 && gameActive == true {
            
            letterState[sender.tag - 1] = letterActive
            
            sender.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
            
            let disableMyButton = sender as? UIButton
            disableMyButton!.enabled = false
            
            for i in 1..<wordToFind.count - 1 {
                if wordToFind[i] == letters[sender.tag - 1] {
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
                    self.hangerImage.image = UIImage(named: "head.png")
                case 2:
                    self.hangerImage.image = UIImage(named: "body.png")
                case 3:
                    self.hangerImage.image = UIImage(named: "left_hand.png")
                case 4:
                    self.hangerImage.image = UIImage(named: "right_hand.png")
                case 5:
                    self.hangerImage.image = UIImage(named: "left_leg.png")
                case 6:
                    self.hangerImage.image = UIImage(named: "right_leg.png")
                default:
                    print("nothing")
                }

                
                
            }
            
            if lettersFound == wordToFind.count - 2 {
                
                gameActive = false
                
                print("You Won")
                
                label = "ΜΠΡΑΒΟ ΚΕΡΔΙΣΕΣ!"
                
                performSegueWithIdentifier("resultSegue", sender: nil)
                
                
            } else if wrongLetters == 6 {
                
                gameActive = false
                
                print("You Lose")
                
                label = "ΛΥΠΑΜΑΙ ΕΧΑΣΕΣ!"
                
                performSegueWithIdentifier("resultSegue", sender: nil)
                
            }
            
        }
        
        
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
