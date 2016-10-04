//
//  WordSelectionViewController.swift
//  Hangman
//
//  Created by Michael Papadopoulos on 23/8/16.
//  Copyright © 2016 Razzmatazz. All rights reserved.
//

import UIKit

class NetWordSelectionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var newWord: UITextField!
    
    // functions to scroll the view for the keyboard
    func adjustInsetForKeyboardShow(show: Bool, notification: NSNotification) {
        guard let value = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.CGRectValue()
        let adjustmentHeight = (CGRectGetHeight(keyboardFrame) + 15) * (show ? 1 : -1)
        scrollView.contentInset.bottom += adjustmentHeight
        scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
    }
    
    func keyboardWillShow(notification: NSNotification) {
        adjustInsetForKeyboardShow(true, notification: notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        adjustInsetForKeyboardShow(false, notification: notification)
    }
    
    // function to hide keyboard when press return key
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    // function to hide keyboard when touch outside of keyboard
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    @IBAction func okButton(sender: AnyObject) {
        
        if newWord.text == nil {
            self.alertMessage("Δεν Έδωσες Λέξη", message: "Δεν έχεις καταχωρήσει λέξη για τον αντίπαλο")
        } else {
            
            let characters = Array(newWord.text!.characters)
            
            // print(characters)
            
            var i = 0
            
            for (i=0; i<characters.count; i+=1) {
                
                hiddenArray.append("_")
                wordToFind.append(String(characters[i]))
                
            }
            
            hiddenArray[0] = String(characters[0])
            
            hiddenArray[i-1] = String(characters.last)
            
            var query = PFUser.query()
            query!.whereKey("objectId", notEqualTo: (PFUser.currentUser()?.objectId)!)
            query!.findObjectsInBackgroundWithBlock { (users: [PFObject]?, error: NSError?) in
                if error != nil {
                    self.alertMessage("Error with Users", message: String(error))
                } else {
                    var usersArray = [PFUser]()
                    if let users = users {
                        for user in users {
                            usersArray.append((user) as! PFUser)
                        }
                    }
                    let selectedUserNumber = Int(arc4random_uniform(UInt32(usersArray.count)))
                    
                    let selectedUser = usersArray[selectedUserNumber]
                    
                    
                    let wordSelected = PFObject(className: "Words")
                    let acl = PFACL()
                    acl.publicReadAccess = true
                    acl.publicWriteAccess = true
                    wordSelected.ACL = acl
                    wordSelected["guestPlayer"] = selectedUser
                    wordSelected["player1ID"] = PFUser.currentUser()
                    wordSelected["word"] = self.newWord.text!
                    wordSelected["isFinished"] = false
                    wordSelected.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) in
                        if success {
                            
                        } else {
                            print("asldkeu \(error!)")
                        }
                    })
                }
            }
            performSegueWithIdentifier("2PlayerSegue", sender: nil)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hiddenArray.removeAll()
        wordToFind.removeAll()
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(WordSelectionViewController.keyboardWillShow(_:)),
            name: UIKeyboardWillShowNotification,
            object: nil
        )
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(WordSelectionViewController.keyboardWillHide(_:)),
            name: UIKeyboardWillHideNotification,
            object: nil
        )
        
        self.newWord.delegate = self
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
