//
//  PublishPicViewController.swift
//  Change My Pic
//
//  Created by Elaine Reyes on 3/3/15.
//  Copyright (c) 2015 UlyssaElaine. All rights reserved.
//

import UIKit
import Accounts
import Social

class PublishPicViewController: UIViewController {

    var profileImage: UIImage? = nil
    var imageText = ""
    var twitterAccount : ACAccount? = nil
    
    
    @IBOutlet weak var profilePicImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.profilePicImageView.image = editPic(self.imageText, image: self.profileImage!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func editPic(text: String, image: UIImage) -> UIImage{
        
        UIGraphicsBeginImageContext(image.size)
        image.drawInRect(CGRectMake(0, 0, image.size.width, image.size.height))
        
        UIColor(white: 0, alpha: 0.0).set()
        CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, image.size.height-(image.size.height*0.2), image.size.width, (image.size.height*0.2)))
        
        var rect = CGRectMake(0, image.size.height-(image.size.height*0.2), image.size.width, image.size.height-(image.size.height*0.2))
        var newText : NSString = text
        var style = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as NSMutableParagraphStyle
        style.alignment = NSTextAlignment.Center
        var attrs = [NSFontAttributeName: UIFont.systemFontOfSize(30), NSForegroundColorAttributeName : UIColor.whiteColor(), NSParagraphStyleAttributeName : style]
        newText.drawInRect(CGRectIntegral(rect), withAttributes: attrs)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    @IBAction func updateTapped(sender: AnyObject) {
        
        let requestAPI = NSURL(string: "https://api.twitter.com/1.1/account/update_profile_image.json")
        
        let picData = UIImagePNGRepresentation(self.profilePicImageView.image)
        let base64Image = picData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        
        let userRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.POST, URL: requestAPI, parameters: ["image" : base64Image])
        
        userRequest.account = self.twitterAccount
        
        
        userRequest.performRequestWithHandler({ (response: NSData!, urlResponse:NSHTTPURLResponse!, error: NSError!) -> Void in
            
            var error = NSErrorPointer()
            
            let responseDictionary = NSJSONSerialization.JSONObjectWithData(response, options: NSJSONReadingOptions.MutableLeaves, error: error) as [String : AnyObject]
            
            if urlResponse.statusCode == 200 {
                var alertController = UIAlertController(title: "Pic Updated!", message: "Congrats! Your Twitter pic was updated!", preferredStyle: UIAlertControllerStyle.Alert)
                var alertAction = UIAlertAction(title: "Awesome!", style: UIAlertActionStyle.Default, handler: nil)
                alertController.addAction(alertAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }else{
                var alertController = UIAlertController(title: "Uh-Oh!", message: "We were unable to update your ic. Sorry dude...", preferredStyle: UIAlertControllerStyle.Alert)
                var alertAction = UIAlertAction(title: "This stinks", style: UIAlertActionStyle.Default, handler: nil)
                alertController.addAction(alertAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            
        })
    }
    
    
}
