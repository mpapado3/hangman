//
//  GamesTableViewController.swift
//  Hangman
//
//  Created by Michael Papadopoulos on 13/9/16.
//  Copyright © 2016 Razzmatazz. All rights reserved.
//

import UIKit
import ParseUI

var activeWord: String = ""

class GamesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    @IBOutlet weak var tableView: UITableView!

    @IBAction func newGameButton(sender: AnyObject) {

    }
    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameId.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        let row = indexPath.row
        cell.textLabel?.text = guestPlayerName[row]
        if gameIsFinished[row] == false {
            cell.detailTextLabel?.text = "Το παιχνίδι είναι ενεργό"
        }
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        activeWord = activeWordArray[indexPath.row]
        
        return indexPath
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                
        tableView.delegate = self
        tableView.dataSource = self


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source




}
