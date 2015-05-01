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

class Contact: UIViewController, MFMailComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Veteran Care Network" // set navigation title
        self.navigationController?.title = "Contact" // set tab bar item title
        self.view.backgroundColor = UIColor(red: 0.31, green: 0.33, blue: 0.34, alpha: 0.85)
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view, typically from a nib.
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func mailComposeController(controller:MFMailComposeViewController, didFinishWithResult result:MFMailComposeResult, error:NSError) {
        switch result.value {
        case MFMailComposeResultCancelled.value:
            println("Mail cancelled")
        case MFMailComposeResultSaved.value:
            println("Mail saved")
        case MFMailComposeResultSent.value:
            var test = "test"
        case MFMailComposeResultFailed.value:
            println("Mail sent failure: %@", [error.localizedDescription])
        default:
            break
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Table View Data Source methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Send feedback"
        case 1:
            cell.textLabel?.text = "General"
        case 2:
            cell.textLabel?.text = "Help"
        default:
            cell.textLabel?.text = "Nothing"
        }
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        if((indexPath.row % 2) == 0) {
            cell.backgroundColor = UIColor(red:0.42, green:0.42, blue:0.42, alpha:1.0)
        }
        cell.tintColor = UIColor.blackColor()
        return cell
    }
    
    // Table View Delegate methods
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var toRecipents = ["service@veterancarenetwork.com"]
        var mc: MFMailComposeViewController = MFMailComposeViewController()
        mc.mailComposeDelegate = self
        switch indexPath.row {
        case 0:
            mc.setSubject("Feedback")
        case 1:
            mc.setSubject("General Contact")
        case 2:
            mc.setSubject("Help")
        default:
            mc.setSubject("Support Email")
        }
        mc.setMessageBody("", isHTML: false)
        mc.setToRecipients(toRecipents)
        
        self.presentViewController(mc, animated: true, completion: nil)
    }

}
