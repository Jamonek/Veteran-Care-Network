//
//  ViewController.swift
//  VCN
//
//  Created by Jamone Alexander Kelly on 2/4/15.
//  Copyright (c) 2015 Veteran Care Network, LLC. All rights reserved.
//  http://jamonek.com
//  http://veterancarenetwork.com
//

import UIKit

class Home: UIViewController {
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let iconImage = UIImage(named: "vcn-logo")
        
        self.title = "Veteran Care Network" // set navigation bar title
        self.navigationController?.title = "Home" // set tab bar item title
        
        self.view.backgroundColor = UIColor(red: 0.43, green: 0.42, blue: 0.42, alpha: 1.0)
        
        let defaults = NSUserDefaults.standardUserDefaults() // Defaults database
        
    
        if(defaults.valueForKey("initialLaunch") == nil) { // Is this our first time launching the application?
            let emptySearch: NSString = ""
            defaults.setBool(true, forKey: "initialLaunch")
            defaults.setBool(true, forKey: "medicareBoolKey")
            defaults.setBool(false, forKey: "facilityBoolKey")
            defaults.setBool(false, forKey: "vaClinicBoolKey")
            defaults.setBool(false, forKey: "vaHospitalBoolKey")
            defaults.setBool(true, forKey: "showVARadius")
            defaults.setObject(emptySearch, forKey: "mapSearchString")
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}

