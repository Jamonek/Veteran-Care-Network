//
//  LayersSubView.swift
//  Veteran Care Network
//
//  Created by Jamone Alexander Kelly on 3/4/15.
//  Copyright (c) 2015 Veteran Care Network, LLC. All rights reserved.
//  http://jamonek.com
//  http://veterancarenetwork.com
//

import UIKit


class LayersSubView:  UIViewController {

    // Our outlet's for 4 UISwitch
    @IBOutlet var medicare: UISwitch!
    @IBOutlet var facility: UISwitch!
    @IBOutlet var vaClinic: UISwitch!
    @IBOutlet var vaHospital: UISwitch!
    @IBOutlet var showRadius: UISwitch!

    
    // Key's for NSUserDefault
    let medicareBoolKeyConstant = "medicareBoolKey"
    let facilityBoolKeyConstant = "facilityBoolKey"
    let vaClinicBoolKeyConstant = "vaClinicBoolKey"
    let vaHospitalBoolKeyConstant = "vaHospitalBoolKey"
    let showRadiusKeyConstant = "showVARadius"
    
    func stateChanged1(switchState: UISwitch) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if switchState.on {
            defaults.setBool(true, forKey: medicareBoolKeyConstant)
            println("Medicare Switch is on")
        } else {
            defaults.setBool(false, forKey: medicareBoolKeyConstant)
            println("Medicare switch is off")
            
        }
    }
    
    func stateChanged2(switchState: UISwitch) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if switchState.on {
            defaults.setBool(true, forKey: facilityBoolKeyConstant)
        } else {
            defaults.setBool(false, forKey: facilityBoolKeyConstant)
        }
    }
    
    func stateChanged3(switchState: UISwitch) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if switchState.on {
            defaults.setBool(true, forKey: vaClinicBoolKeyConstant)
        } else {
            defaults.setBool(false, forKey: vaClinicBoolKeyConstant)
        }
    }
    
    func stateChanged4(switchState: UISwitch) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if switchState.on {
            defaults.setBool(true, forKey: vaHospitalBoolKeyConstant)
        } else {
            defaults.setBool(false, forKey: vaHospitalBoolKeyConstant)
        }
    }
    
    func updateRadiusVar(switchState: UISwitch) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if switchState.on {
            defaults.setBool(true, forKey: showRadiusKeyConstant)
        } else {
            defaults.setBool(false, forKey: showRadiusKeyConstant)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        
        
        var medicareBool : Bool = defaults.valueForKey(medicareBoolKeyConstant) as! Bool , facilityBool : Bool = defaults.valueForKey(facilityBoolKeyConstant) as! Bool, clinicBool : Bool = defaults.valueForKey(vaClinicBoolKeyConstant) as! Bool, hospitalBool : Bool = defaults.valueForKey(vaHospitalBoolKeyConstant) as! Bool
        var showRadBool : Bool = defaults.valueForKey(showRadiusKeyConstant) as! Bool
        
        medicare.setOn(medicareBool, animated: true)
        facility.setOn(facilityBool, animated: true)
        vaClinic.setOn(clinicBool, animated: true)
        vaHospital.setOn(hospitalBool, animated: true)
        showRadius.setOn(showRadBool, animated: true)
        
        medicare.addTarget(self, action: Selector("stateChanged1:"), forControlEvents: UIControlEvents.ValueChanged)
        facility.addTarget(self, action: Selector("stateChanged2:"), forControlEvents: UIControlEvents.ValueChanged)
        vaClinic.addTarget(self, action: Selector("stateChanged3:"), forControlEvents: UIControlEvents.ValueChanged)
        vaHospital.addTarget(self, action: Selector("stateChanged4:"), forControlEvents: UIControlEvents.ValueChanged)
        showRadius.addTarget(self, action: Selector("updateRadiusVar:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}