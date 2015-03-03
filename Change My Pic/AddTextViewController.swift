//
//  AddTextViewController.swift
//  Change My Pic
//
//  Created by Elaine Reyes on 3/3/15.
//  Copyright (c) 2015 UlyssaElaine. All rights reserved.
//

import UIKit
import Accounts

class AddTextViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    var profileImage : UIImage? = nil
    var twitterAccount : ACAccount? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let publishPicViewController = segue.destinationViewController as PublishPicViewController
        publishPicViewController.profileImage = self.profileImage
        publishPicViewController.imageText = self.textField.text
        publishPicViewController.twitterAccount = self.twitterAccount
    }
    

}
