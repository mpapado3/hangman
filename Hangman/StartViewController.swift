//
//  StartViewController.swift
//  Hangman
//
//  Created by Michael Papadopoulos on 4/8/16.
//  Copyright © 2016 Razzmatazz. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit

class StartViewController: UIViewController {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    @IBOutlet weak var newPlayerButtonOutlet: UIButton!
    @IBOutlet weak var connectPlayerButtonOutlet: UIButton!
    @IBOutlet weak var detailsImageBackground: UIImageView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var acceptButtonOutlet: UIButton!
    
    // variables for saving the email and password
    
    var registerUser: Bool = true
    
    @IBAction func facebookConnect(sender: AnyObject) {
        
        /*
        let permissions = ["public_profile"]
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions, block: {(user: PFUser?, error: NSError?) -> Void in
            
            if let error = error {
                print(error)
            } else {
                if let user = user {
                    print(user)
                }
            }
            
        })
       */
        
    }
    @IBAction func newPlayerButton(sender: AnyObject) {
        
        newPlayerButtonOutlet.hidden = true
        connectPlayerButtonOutlet.hidden = true
        detailsImageBackground.hidden = false
        detailsImageBackground.image = UIImage(named: "create_account_details.png")
        emailField.hidden = false
        passwordField.hidden = false
        acceptButtonOutlet.hidden = false
        registerUser = true
        
        
    }
    
    @IBAction func connectPlayerButton(sender: AnyObject) {
        
        newPlayerButtonOutlet.hidden = true
        connectPlayerButtonOutlet.hidden = true
        detailsImageBackground.hidden = false
        detailsImageBackground.image = UIImage(named: "connect_account_details.png")
        emailField.hidden = false
        passwordField.hidden = false
        acceptButtonOutlet.hidden = false
        registerUser = false
        
    }
    
    
    @IBAction func acceptButton(sender: AnyObject) {
        
        if registerUser == true {
            
            if emailField.text == "" || passwordField.text == "" {
                
                alertMessage("Error in Form!", message: "All fields are nessecary")
                
            } else {
                
                activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
                activityIndicator.center = self.view.center
                activityIndicator.hidesWhenStopped = true
                activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
                view.addSubview(activityIndicator)
                activityIndicator.startAnimating()
                UIApplication.sharedApplication().beginIgnoringInteractionEvents()
                
                var errorMessage = "Please try again Later!"
                
                let user = PFUser()
                user.email = String(emailField.text!)
                user.username = String(emailField.text!)
                user.password = String(passwordField.text!)
                
                user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                    
                    self.activityIndicator.startAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if error == nil {
                        
                        print("User Signed: ", (user.username)!)
                        
                        self.performSegueWithIdentifier("startSegue", sender: self)
                        
                    } else {
                        
                        if let errorString = error!.userInfo["error"] as? String {
                            errorMessage = errorString
                        }
                        
                        self.alertMessage("Failed signup", message: errorMessage)
                    }
                    
                })
                
            }
            
        } else if registerUser == false {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            var errorMessage = "Please try again Later!"
            
            PFUser.logInWithUsernameInBackground(emailField.text!, password: passwordField.text!, block: { (user, error) -> Void in
                
                self.activityIndicator.startAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                if user != nil {
                    
                    self.performSegueWithIdentifier("startSegue", sender: self)
                    
                } else {
                    
                    if let errorString = error!.userInfo["error"] as? String {
                        errorMessage = errorString
                    }
                    
                    self.alertMessage("Failed signup", message: errorMessage)
                }
            })

            
        }
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsImageBackground.hidden = true
        emailField.hidden = true
        passwordField.hidden = true
        acceptButtonOutlet.hidden = true

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if let username = PFUser.currentUser()?.username {
            
            self.performSegueWithIdentifier("startSegue", sender: self)
            
            
        }
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alertMessage(title: String, message: String) {
        
        if #available(iOS 8.0, *) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(alert, animated: true, completion: nil)
            
        } else {
            // Fallback on earlier versions
        }
        
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
