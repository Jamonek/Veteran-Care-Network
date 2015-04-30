//
//  About.swift
//  VCN
//
//  Created by Jamone Alexander Kelly on 2/14/15.
//  Copyright (c) 2015 Veteran Care Network, LLC. All rights reserved.
//  http://jamonek.com
//  http://veterancarenetwork.com
//

import UIKit

class About: UIViewController {
    
    @IBOutlet var segControl: UISegmentedControl!
    @IBOutlet var container: UIView!
    var vc : UIViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Veteran Care Network" // set navigation title
        self.navigationController?.title = "About" // set tab bar item title
        
        //segControl.backgroundColor = UIColor(red: 0.31, green: 0.33, blue: 0.34, alpha: 0.85)
        // load default view into container
        let viewSub = UIStoryboard(name: "Main", bundle: nil)
        self.vc = viewSub.instantiateViewControllerWithIdentifier("aboutSub") as! UIViewController
        var sub = self.vc.view
        container.addSubview(sub)
        
        container.clipsToBounds = true
        
        container.userInteractionEnabled = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segChange(sender: UISegmentedControl) {
        let viewSub = UIStoryboard(name: "Main", bundle: nil)
        switch sender.selectedSegmentIndex {
        case 0:
            // load about
            self.vc = viewSub.instantiateViewControllerWithIdentifier("aboutSub") as! UIViewController
            var sub = self.vc.view
            container.addSubview(sub)
            container.clipsToBounds = true
        case 1:
            // load director
            self.vc = viewSub.instantiateViewControllerWithIdentifier("directorSub")as! UIViewController
            var sub = self.vc.view
            container.addSubview(sub)
            container.clipsToBounds = true
        default:
            println("Nothing")
        }
    }

    
}