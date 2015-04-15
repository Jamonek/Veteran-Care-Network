//
//  Video.swift
//  Veteran Care Network
//
//  Created by Jamone Alexander Kelly on 3/26/15.
//  Copyright (c) 2015 Veteran Care Network, LLC. All rights reserved.
//

import UIKit

class Video : UIViewController {
    
    
    
    override func viewDidLoad() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func videoButtonPressed(sender: UIButton) {
        
        UIApplication.sharedApplication().openURL(NSURL(string:"https://www.youtube.com/watch?v=Goc6U8y3lg0")!)
    }
    
}
