//
//  LayerSub.swift
//  Veteran Care Network
//
//  Created by Jamone Alexander Kelly on 3/4/15.
//  Copyright (c) 2015 Veteran Care Network, LLC. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LayerSub : UIViewController {
    let mapVC = MapVC()
    /*
    @IBOutlet weak var hosMedicareSwitch: UISwitch!
    @IBOutlet weak var healthFacilitiesSwitch: UISwitch!
    @IBOutlet weak var clinicsSwitch: UISwitch!
    @IBOutlet weak var hospitalsSwitch: UISwitch!
    */
    var fcBool : Bool = false
    var mdBool : Bool = false
    var vcBool : Bool = false
    var vhBool : Bool = false
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        /*
        hospitalsMedicareSwitch.addTarget(self, action: Selector("hMState:"), forControlEvents: UIControlEvents.ValueChanged)
        facilitiesSwitch.addTarget(self, action: Selector("hFState:"), forControlEvents: UIControlEvents.ValueChanged)
        clinicsSwitch.addTarget(self, action: Selector("vCState:"), forControlEvents: UIControlEvents.ValueChanged)
        vaHospitalsSwitch.addTarget(self, action: Selector("vHState:"), forControlEvents: UIControlEvents.ValueChanged)
        */
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        /*
        hosMedicareSwitch.addTarget(self, action: Selector("hMState:"), forControlEvents: UIControlEvents.ValueChanged)
        healthFacilitiesSwitch.addTarget(self, action: Selector("hFState:"), forControlEvents: UIControlEvents.ValueChanged)
        clinicsSwitch.addTarget(self, action: Selector("vCState:"), forControlEvents: UIControlEvents.ValueChanged)
        hospitalsSwitch.addTarget(self, action: Selector("vHState:"), forControlEvents: UIControlEvents.ValueChanged)
        */
    }
    
    /*
    func hMState(switchState: UISwitch) {
        if switchState.on {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                self.mapVC.getCloseLocations("md")
                println("Medicare annotations added")
                self.mdBool = true
            }
        } else if mdBool {
            mapVC.mapView.removeAnnotations(mapVC.hMLocations)
            mapVC.hMLocations.removeAllObjects()
            self.mdBool = false
        }
    }
    
    func hFState(switchState: UISwitch) {
        if switchState.on {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                self.mapVC.getCloseLocations("fc")
                println("Medicare annotations added")
                self.fcBool = true
            }
        } else if fcBool {
            mapVC.mapView.removeAnnotations(mapVC.hFLocations)
            mapVC.hFLocations.removeAllObjects()
            mapVC.getCloseLocations("md")
            self.fcBool = false
        }
    }
    
    func vCState(switchState: UISwitch) {
        if switchState.on {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                self.mapVC.getCloseLocations("vc")
                println("Medicare annotations added")
                self.vcBool = true
            }
        } else if vcBool{
            mapVC.mapView.removeAnnotations(mapVC.vCLocations)
            mapVC.vCLocations.removeAllObjects()
            self.vcBool = false
        }
    }
    
    func vHState(switchState: UISwitch) {
        if switchState.on {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                self.mapVC.getCloseLocations("vh")
                println("Medicare annotations added")
                self.vhBool = true
            }
        } else if vhBool {
            mapVC.mapView.removeAnnotations(mapVC.vHLocations)
            mapVC.vHLocations.removeAllObjects()
            self.vhBool = false
        }
    }
    */
    
    
}