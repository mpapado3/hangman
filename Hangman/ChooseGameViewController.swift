//
//  ChooseGameViewController.swift
//  Hangman
//
//  Created by Michael Papadopoulos on 11/9/16.
//  Copyright © 2016 Razzmatazz. All rights reserved.
//

import UIKit

class ChooseGameViewController: UIViewController {

    @IBOutlet weak var notificationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationLabel.text = String(gamesObjectId.count)

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
