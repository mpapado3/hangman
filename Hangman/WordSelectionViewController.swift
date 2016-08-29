//
//  WordSelectionViewController.swift
//  Hangman
//
//  Created by Michael Papadopoulos on 23/8/16.
//  Copyright © 2016 Razzmatazz. All rights reserved.
//

import UIKit

var hiddenArray = [String]()

var wordToFind = [String]()

class WordSelectionViewController: UIViewController {
    
    
    @IBOutlet weak var newWord: UITextField!
    
    @IBAction func okButton(sender: AnyObject) {
        
        let characters = Array(newWord.text!.characters)
        
        // print(characters)
        
        newWord.text = ""
        
        var i = 0
        
        for (i=0; i<characters.count; i+=1) {
            
            hiddenArray.append("_")
            wordToFind.append(String(characters[i]))
            
        }
        
        hiddenArray[0] = String(characters[0])
        
        hiddenArray[i-1] = String(characters.last)
        
        performSegueWithIdentifier("2PlayerSegue", sender: nil)
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    /*
    func adjustInsetForKeyboardShow(show: Bool, notification: NSNotification) {
        guard let value = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.CGRectValue()
        let adjustmentHeight = (CGRectGetHeight(keyboardFrame) + 10) * (show ? 1 : -1)
        addBookScrollView.contentInset.bottom += adjustmentHeight
        addBookScrollView.scrollIndicatorInsets.bottom += adjustmentHeight
    }
    
    func keyboardWillShow(notification: NSNotification) {
        adjustInsetForKeyboardShow(true, notification: notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        adjustInsetForKeyboardShow(false, notification: notification)
    }
    */

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
