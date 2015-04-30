//
//  Contact.swift
//  VCN
//
//  Created by Jamone Alexander Kelly on 2/14/15.
//  Copyright (c) 2015 Veteran Care Network, LLC. All rights reserved.
//  http://jamonek.com
//  http://veterancarenetwork.com
//

import UIKit
import MessageUI

class Contact: UIViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet var subjectText: UITextField!
    @IBOutlet var contentText: UITextView!
    @IBOutlet var updateText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Veteran Care Network" // set navigation title
        self.navigationController?.title = "Contact" // set tab bar item title
        self.view.backgroundColor = UIColor(red: 0.31, green: 0.33, blue: 0.34, alpha: 0.85)
        
       
        // Do any additional setup after loading the view, typically from a nib.
        updateText.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendEmail(sender: UIButton) {
        
        if subjectText.text.isEmpty || contentText.text.isEmpty {
            return
        }
        
        var toRecipents = ["service@veterancarenetwork.com"]
        var mc: MFMailComposeViewController = MFMailComposeViewController()
        mc.mailComposeDelegate = self
        mc.setSubject("\(subjectText.text)")
        mc.setMessageBody(contentText.text, isHTML: false)
        mc.setToRecipients(toRecipents)
        
        self.presentViewController(mc, animated: true, completion: nil)
    }

    func mailComposeController(controller:MFMailComposeViewController, didFinishWithResult result:MFMailComposeResult, error:NSError) {
        switch result.value {
        case MFMailComposeResultCancelled.value:
            println("Mail cancelled")
        case MFMailComposeResultSaved.value:
            println("Mail saved")
        case MFMailComposeResultSent.value:
            updateText.fadeIn(completion: {
                (finished: Bool) -> Void in
                self.updateText.text = "Mail successfully sent!"
                self.updateText.fadeIn()
            })
        case MFMailComposeResultFailed.value:
            println("Mail sent failure: %@", [error.localizedDescription])
        default:
            break
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
