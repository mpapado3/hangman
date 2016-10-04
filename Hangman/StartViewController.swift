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
import FBSDKLoginKit
import ParseFacebookUtilsV4

extension UIViewController {
    
    // extend the view controller to have the alert func globally 
    
    func alertMessage(title: String, message: String) {

            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        
    }

    
}

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
        
        
        let permissions = ["public_profile", "email"]
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) {
            (user: PFUser?, error: NSError?) -> Void in
            if let user = user {
                if user.isNew {
                    print("asldkeu User signed up and logged in through Facebook!")
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = storyboard.instantiateViewControllerWithIdentifier("MainViewController")
                    self.presentViewController(viewController, animated: true, completion: nil)
                    
                } else {
                    print("asldkeu User logged in through Facebook!")
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = storyboard.instantiateViewControllerWithIdentifier("MainViewController") 
                    self.presentViewController(viewController, animated: true, completion: nil)

                }
            } else {
                print("asldkeu Uh oh. The user cancelled the Facebook login.")
            }
        }
        
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
        
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email"])
        graphRequest.startWithCompletionHandler( {
            
            (connection, result, error) -> Void in
            
            if error != nil {
                
                print("asldkeu Facebok Connect \(error)")
                
            } else if let result = result {
                
                print("asldkeu facebook \(result["name"]!)")
                
                PFUser.currentUser()?["username"] = result["email"]!
                PFUser.currentUser()?["email"] = result["email"]!
                PFUser.currentUser()?["name"] = result["name"]!
                
                PFUser.currentUser()?.saveInBackgroundWithBlock({ (result: Bool?, error: NSError?) in
                    if error != nil {
                        print("asldkeu facebook user details error \(error)")
                    } else {
                        
                    }
                })
                
                
                self.performSegueWithIdentifier("startSegue", sender: self)
            }
            
        })


        detailsImageBackground.hidden = true
        emailField.hidden = true
        passwordField.hidden = true
        acceptButtonOutlet.hidden = true

        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(animated: Bool) {
        


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
