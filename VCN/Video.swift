//
//  Video.swift
//  Veteran Care Network
//
//  Created by Jamone Alexander Kelly on 3/26/15.
//  Copyright (c) 2015 Veteran Care Network, LLC. All rights reserved.
//  http://jamonek.com
//  http://veterancarenetwork.com
//

import UIKit

class Video : UIViewController {
    
    
    
    override func viewDidLoad() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Open tutorial of how to use the application on Youtube when "Video" button is tapped
    @IBAction func videoButtonPressed(sender: UIButton) {
        
        UIApplication.sharedApplication().openURL(NSURL(string:"https://www.youtube.com/watch?v=WhPx-fF_hNo")!) // Open link to YouTube in browser or app
    }
    
}
