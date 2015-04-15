//
//  About.swift
//  VCN
//
//  Created by Jamone Alexander Kelly on 2/14/15.
//  Copyright (c) 2015 Veteran Care Network, LLC. All rights reserved.
//

import UIKit

class About: UIViewController {
    
    @IBOutlet var container: UIView!
    var vc : UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Veteran Care Network"
        self.navigationController?.title = "About"
        
        // load default view into container
        let view = UIStoryboard(name: "Main", bundle: nil)
        self.vc = view.instantiateViewControllerWithIdentifier("aboutSub") as! UIViewController
        let sub = self.vc.view
        
        container.addSubview(sub)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segChange(sender: UISegmentedControl) {
        let view = UIStoryboard(name: "Main", bundle: nil)
        switch sender.selectedSegmentIndex {
        case 0:
            // load about
            self.vc = view.instantiateViewControllerWithIdentifier("aboutSub") as! UIViewController
            let sub = self.vc.view
            container.addSubview(sub)
        case 1:
            // load director
            self.vc = view.instantiateViewControllerWithIdentifier("directorSub")as! UIViewController
            let sub = self.vc.view
            container.addSubview(sub)
        default:
            println("Nothing")
        }
    }

    
}