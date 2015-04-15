//
//  Services.swift
//  VCN
//
//  Created by Jamone Alexander Kelly on 2/14/15.
//  Copyright (c) 2015 Veteran Care Network, LLC. All rights reserved.
//  http://jamonek.com
//  http://veterancarenetwork.com
//

import UIKit

class Search: UIViewController {
    @IBOutlet var searchTerms: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func findLocation(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // Check if there is a location in the UITextField
        if(searchTerms.text.isEmpty)
        {
            var alert = UIAlertController(title: "Error", message: "Search term is missing.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        // save location to database until we find better method
        var searchStringNS : NSString = searchTerms.text
        
        defaults.setObject(searchStringNS, forKey: "mapSearchString") // saving of search term triggers observer in MapVC.swift
        
    }

    
}