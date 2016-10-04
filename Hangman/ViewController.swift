//
//  ViewController.swift
//  Hangman
//
//  Created by Michael Papadopoulos on 21/9/15.
//  Copyright © 2015 Razzmatazz. All rights reserved.
//

import UIKit
import Parse

var player1Id = [PFUser]()
var guestPlayerId = [PFUser]()
var guestPlayerName = [String]()
var gameIsFinished = [Bool]()
var gameId = [String]()
var activeWordArray = [String]()

class ViewController: UIViewController {

    @IBOutlet weak var notificationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         notificationLabel.hidden = true
        
        // check how many open games the current player haas and show the number in notification icon
        
        let query = PFQuery(className: "Words")
        query.whereKey("guestPlayer", equalTo: PFUser.currentUser()!)
        query.whereKey("isFinished", equalTo: false)
        query.includeKey("guestPlayer")
        query.findObjectsInBackgroundWithBlock { (items: [PFObject]?, error: NSError?) in
            if error != nil {
                self.alertMessage("Notification Error", message: String(error))
            } else {

                if items!.count != 0 {
                    self.notificationLabel.hidden = false
                    gameId.removeAll(keepCapacity: true)
                    player1Id.removeAll(keepCapacity: true)
                    guestPlayerId.removeAll(keepCapacity: true)
                    gameIsFinished.removeAll(keepCapacity: true)
                    guestPlayerName.removeAll(keepCapacity: true)
                    activeWordArray.removeAll(keepCapacity: true)
                    
                    if let items = items {
                        for item in items {
                            gameId.append(String(item.objectId!))
                            guestPlayerId.append((item["guestPlayer"]) as! PFUser)
                            player1Id.append((item["player1ID"]) as! PFUser)
                            gameIsFinished.append((item["isFinished"] as? Bool)!)
                            let user = item["guestPlayer"] as! PFObject
                            let name = user["name"] as! String
                            guestPlayerName.append(name)
                            activeWordArray.append(item["word"] as! String)
                        }
                    }
                }
                self.notificationLabel.text = String(items!.count)

            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

