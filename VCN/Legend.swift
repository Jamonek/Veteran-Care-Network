//
//  Legend.swift
//  VCN
//
//  Created by Jamone Alexander Kelly on 3/3/15.
//  Copyright (c) 2015 Veteran Care Network, LLC. All rights reserved.
//  http://jamonek.com
//  http://veterancarenetwork.com
//

import UIKit

class Legend : UIViewController {
    @IBOutlet weak var containerView: UIView!
    var vc : UIViewController!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // load default view into container
        let view = UIStoryboard(name: "Main", bundle: nil)
        self.vc = view.instantiateViewControllerWithIdentifier("layersSub") as! UIViewController
        let sub = self.vc.view
        
        containerView.addSubview(sub) // Add our default view, layersSub, to the UIView
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentChange(sender: UISegmentedControl) { // Display desired view based on UISegmentedControl value (Layers, Legend)
        
        switch(sender.selectedSegmentIndex)
        {
            case 0:
                let view = UIStoryboard(name: "Main", bundle: nil)
                self.vc = view.instantiateViewControllerWithIdentifier("layersSub") as! UIViewController
                let sub = self.vc.view
                
                containerView.addSubview(sub)
            case 1:
                let view = UIStoryboard(name: "Main", bundle: nil)
                self.vc = view.instantiateViewControllerWithIdentifier("legendSub") as! UIViewController
                let sub = self.vc.view
            
                containerView.addSubview(sub)
            default:
                println("Test")
        }
    }
}