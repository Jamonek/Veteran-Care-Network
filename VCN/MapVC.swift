//
//  mapVC.swift
//  VCN
//
//  Created by Jamone Alexander Kelly on 2/13/15.
//  Copyright (c) 2015 Veteran Care Network, LLC. All rights reserved.
//  http://jamonek.com
//  http://veterancarenetwork.com
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var mapView : MKMapView!
    var hMLocations = NSMutableArray()
    var hFLocations = NSMutableArray()
    var vCLocations = NSMutableArray()
    var vHLocations = NSMutableArray()
    let locationManager = CLLocationManager()
    var userLat : Double
    var userLng : Double
    var popover: UIPopoverController? = nil
    @IBOutlet weak var showLocationButton: UIBarButtonItem!
    @IBOutlet weak var searchLocationButton: UIBarButtonItem!
    @IBOutlet weak var legendButton: UIBarButtonItem!
    @IBOutlet weak var helpButton: UIBarButtonItem!
    var oldController : UIViewController!
    var oldControllerBool : Bool = false
    var fcBool : Bool = false
    var mdBool : Bool = false
    var vcBool : Bool = false
    var vhBool : Bool = false
    let defaults = NSUserDefaults.standardUserDefaults()
    // Key's for NSUserDefault
    let medicareBoolKeyConstant = "medicareBoolKey"
    let facilityBoolKeyConstant = "facilityBoolKey"
    let vaClinicBoolKeyConstant = "vaClinicBoolKey"
    let vaHospitalBoolKeyConstant = "vaHospitalBoolKey"
    let showRadiusKeyConstant = "showVARadius"
    let mapSearchKeyConstant = "mapSearchString"
    var searchBool = false
    var zoomLevelValue = 0
    var centerSearch : CLLocationCoordinate2D? = nil
    var regionSearch : MKCoordinateRegion? = nil
    
    required init(coder aDecoder: NSCoder) {
        userLat = 0.0
        userLng = 0.0
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        userLat = 0.0
        userLng = 0.0
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Veteran Care Network" // set navigation title
        self.navigationController?.title = "Map" // set tab bar item title
        
        mapView.delegate = self
        
        defaults.addObserver(self, forKeyPath: facilityBoolKeyConstant, options: NSKeyValueObservingOptions(), context: nil) // Observer for checking if UISwitch value has changed to enable/disable map annotations for selected location type
        defaults.addObserver(self, forKeyPath: medicareBoolKeyConstant, options: NSKeyValueObservingOptions(), context: nil) // Observer for checking if UISwitch value has changed to enable/disable map annotations for selected location type
        defaults.addObserver(self, forKeyPath: vaHospitalBoolKeyConstant, options: NSKeyValueObservingOptions(), context: nil) // Observer for checking if UISwitch value has changed to enable/disable map annotations for selected location type
        defaults.addObserver(self, forKeyPath: vaClinicBoolKeyConstant, options: NSKeyValueObservingOptions(), context: nil) // Observer for checking if UISwitch value has changed to enable/disable map annotations for selected location type
        defaults.addObserver(self, forKeyPath: showRadiusKeyConstant, options: NSKeyValueObservingOptions(), context: nil) // Observer for checking if 40 mile radius should display or hide
        defaults.addObserver(self, forKeyPath: mapSearchKeyConstant, options: NSKeyValueObservingOptions(), context: nil) // Observer that checks if a search has been requested
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
            self.userLat = locationManager.location.coordinate.latitude
            self.userLng = locationManager.location.coordinate.longitude
            self.mapView.setUserTrackingMode(MKUserTrackingMode.FollowWithHeading, animated: true);
            
        }
        
        mapView.showsUserLocation = true // Show current location of user
        mapView.mapType = MKMapType.Standard // Standard look of the map
        mapView.zoomEnabled = true // Allow the user to zoom on the map via finger gestures
        
        dispatch_async(dispatch_get_main_queue()) {
            if((self.defaults.valueForKey(self.facilityBoolKeyConstant) as! Bool) != false) {
                self.getCloseLocations("fc")
            }
            if((self.defaults.valueForKey(self.medicareBoolKeyConstant) as! Bool) != false) {
                self.getCloseLocations("md")
            }
            if((self.defaults.valueForKey(self.vaHospitalBoolKeyConstant) as! Bool) != false) {
                self.getCloseLocations("vh")
            }
            if((self.defaults.valueForKey(self.vaClinicBoolKeyConstant) as! Bool) != false) {
                self.getCloseLocations("vc")
            }
        }
    }
    
    //Observe changes
    override func observeValueForKeyPath(keyPath: String, ofObject object: (AnyObject!), change: ([NSObject : AnyObject]!), context: UnsafeMutablePointer<Void>) {
        println(keyPath)
        switch keyPath {
        case facilityBoolKeyConstant:
            if((self.defaults.valueForKey(self.facilityBoolKeyConstant) as! Bool) == false) {
                self.removeLocations("fc")
            } else {
                self.getCloseLocations("fc")
            }
        case medicareBoolKeyConstant:
            if((self.defaults.valueForKey(self.medicareBoolKeyConstant) as! Bool) == false) {
                self.removeLocations("md")
            } else {
                self.getCloseLocations("md")
            }
        case vaHospitalBoolKeyConstant:
            if((self.defaults.valueForKey(self.vaHospitalBoolKeyConstant) as! Bool) == false) {
                if(self.vHLocations.count > 0 && (self.defaults.valueForKey(showRadiusKeyConstant) as! Bool)) {
                    self.removeRadiusCircle()
                }
                self.removeLocations("vh")
            } else {
                self.getCloseLocations("vh")
            }
        case vaClinicBoolKeyConstant:
            if((self.defaults.valueForKey(self.vaClinicBoolKeyConstant) as! Bool) == false) {
                self.removeLocations("vc")
            } else {
                self.getCloseLocations("vc")
            }
        case showRadiusKeyConstant:
            if((self.defaults.valueForKey(showRadiusKeyConstant) as! Bool) == false) {
                if(self.vHLocations.count > 0) {
                    let countLocations = self.vHLocations.count
                    for i in 0..<countLocations {
                        var vH = self.vHLocations[i] as! PinPointAnnotation
                        var lat = vH.coordinate.latitude
                        var lon = vH.coordinate.longitude
                        var radius = CLLocation(latitude: lat as CLLocationDegrees, longitude: lon as CLLocationDegrees)
                        println("Test remove VA Radius")
                        self.removeRadiusCircle()
                    }
                }
            } else {
                if(self.vHLocations.count > 0) {
                    let countLocations = self.vHLocations.count
                    for i in 0..<countLocations {
                        var vH = self.vHLocations[i] as! PinPointAnnotation
                        var lat = vH.coordinate.latitude
                        var lon = vH.coordinate.longitude
                        var radius = CLLocation(latitude: lat as CLLocationDegrees, longitude: lon as CLLocationDegrees)
                        println("Test insert VA radius")
                        self.addRadiusCircle(radius)
                    }
                }
            }
        case mapSearchKeyConstant:
            var searchStringCheck = self.defaults.valueForKey(mapSearchKeyConstant) as! String
            if !searchStringCheck.isEmpty {
                var geocoder = CLGeocoder()
                println("Testing search")
                var searchString = defaults.valueForKey(mapSearchKeyConstant) as! String
                geocoder.geocodeAddressString(searchString,completionHandler:  {(placemarks: [AnyObject]!, error: NSError!) -> Void in
                    if let placemark = placemarks?[0] as? CLPlacemark {
                        println("Testing search")
                        //self.mapView.addAnnotation(MKPlacemark(placemark: placemark))
                        self.userLat = placemark.location.coordinate.latitude
                        self.userLng = placemark.location.coordinate.longitude
                        self.searchBool = true
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            self.getCloseLocations("md")
                            self.getCloseLocations("vc")
                            self.getCloseLocations("vh")
                            self.getCloseLocations("fc")
                        })
                        
                        let countLocations = self.vHLocations.count
                        if countLocations > 0 {
                            for i in 0..<countLocations {
                                var vH = self.vHLocations[i] as! PinPointAnnotation
                                var lat = vH.coordinate.latitude
                                var lon = vH.coordinate.longitude
                                var radius = CLLocation(latitude: lat as CLLocationDegrees, longitude: lon as CLLocationDegrees)
                                println("Test insert VA radius initial")
                                self.addRadiusCircle(radius)
                            }
                        }
                        
                        let center = CLLocationCoordinate2D(latitude: self.userLat, longitude: self.userLng)
                        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
                        self.zoomLevelValue = 1
                        self.mapView.setRegion(region, animated: true)
                        self.searchBool = false
                        
                    } else {
                        println("Unable to locate")
                    }
                })
            }
        default:
            println("nothing")
        }
    }
    
    deinit {
        //Remove observer
        defaults.removeObserver(self, forKeyPath: facilityBoolKeyConstant, context: nil)
        defaults.removeObserver(self, forKeyPath: medicareBoolKeyConstant, context: nil)
        defaults.removeObserver(self, forKeyPath: vaClinicBoolKeyConstant, context: nil)
        defaults.removeObserver(self, forKeyPath: vaHospitalBoolKeyConstant, context: nil)
        defaults.removeObserver(self, forKeyPath: showRadiusKeyConstant, context: nil)
        defaults.removeObserver(self, forKeyPath: mapSearchKeyConstant, context: nil)
    }
    
    func removeLocations(table: String) {
        switch table {
        case "fc":
            if self.hFLocations.count > 0 {
                self.mapView.removeAnnotations(self.hFLocations as [AnyObject])
                println("FC: \(self.hFLocations.count)")
                self.hFLocations.removeAllObjects()
            }
        case "md":
            if self.hMLocations.count > 0 {
                self.mapView.removeAnnotations(self.hMLocations as [AnyObject])
                println("MD: \(self.hMLocations.count)")
                self.hMLocations.removeAllObjects()
            }
        case "vh":
            if self.vHLocations.count > 0 {
                self.mapView.removeAnnotations(self.vHLocations as [AnyObject])
                println("VH: \(self.vHLocations.count)")
                self.vHLocations.removeAllObjects()
            }
        case "vc":
            if self.vCLocations.count > 0 {
                self.mapView.removeAnnotations(self.vCLocations as [AnyObject])
                println("VC: \(self.vCLocations.count)")
                self.vCLocations.removeAllObjects()
            }
        default:
            println("Do nothin..")
            
        }
        
    }
    
    // 5 to 10 mile radius
    // 40 mile locations contain permanent shadow
    
    func getCloseLocations(table : String) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
            let session = NSURLSession.sharedSession()
            let url: NSURL = NSURL(string: "http://api.veterancarenetwork.com/getAnnotations.php?type=distance&lat=\(self.userLat)&lon=\(self.userLng)&ref=\(table)")!
            println("http://api.veterancarenetwork.com/getAnnotations.php?type=distance&lat=\(self.userLat)&lon=\(self.userLng)&ref=\(table)")
            let networkTask = session.dataTaskWithURL(url, completionHandler: {data, response, error  -> Void in
                var result =  NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as!
                NSMutableDictionary
                var results : NSMutableDictionary = result["distance"] as! NSMutableDictionary
                dispatch_async(dispatch_get_main_queue(), {
                    var status: AnyObject = results.valueForKey("status")!
                    println("Status: \(status)")
                    if(status as! NSInteger == 200) {
                        
                        var resultsArray : NSMutableArray = results.valueForKey("content") as! NSMutableArray
                        for point in resultsArray {
                            var lat         = (point["lat"] as! NSString).doubleValue
                            var lon         = (point["lon"] as! NSString).doubleValue
                            var street      = point["street"] as! String
                            var city        = point["city"] as! String
                            var state       = point["state"] as! String
                            var phonenumber = point["phonenumber"] as! String
                            var zipcode     = point["zipcode"] as! String
                            var subtitle    = "\(city), \(state) \(zipcode)"
                            
                            switch table {
                            case "fc":
                                var title       = point["name"] as! String
                                var coord       = CLLocationCoordinate2DMake(lat, lon)
                                var radius = CLLocation(latitude: lat as CLLocationDegrees, longitude: lon as CLLocationDegrees)
                                var annotation  = PinPointAnnotation(coordinate: coord, title: title, subtitle: subtitle, image: UIImage(named: "healthFacility")!, type: table)
                                annotation.city = city
                                annotation.street = street
                                annotation.state = state
                                annotation.zip = zipcode
                                annotation.networkType = (point["type"] as! String)
                                annotation.phonenumber = phonenumber
                                self.hFLocations.addObject(annotation)
                                println("FC TYPE: \(table)")
                            case "md":
                                var title       = point["name"] as! String
                                var coord       = CLLocationCoordinate2DMake(lat, lon)
                                var radius = CLLocation(latitude: lat as CLLocationDegrees, longitude: lon as CLLocationDegrees)
                                var annotation  = PinPointAnnotation(coordinate: coord, title: title, subtitle: subtitle, image: UIImage(named: "hospitalMedicare")!, type: table)
                                annotation.city = city
                                annotation.street = street
                                annotation.state = state
                                annotation.zip = zipcode
                                annotation.network = (point["network"] as! String)
                                annotation.networkType = (point["type"] as! String)
                                annotation.phonenumber = phonenumber
                                self.hMLocations.addObject(annotation)
                                println("MD TYPE: \(table)")
                            case "vc":
                                var title = "VA Clinic"
                                var coord       = CLLocationCoordinate2DMake(lat, lon)
                                var radius = CLLocation(latitude: lat as CLLocationDegrees, longitude: lon as CLLocationDegrees)
                                var annotation  = PinPointAnnotation(coordinate: coord, title: title, subtitle: subtitle, image: UIImage(named: "vaClinic")!, type: table)
                                annotation.city = city
                                annotation.street = street
                                annotation.state = state
                                annotation.zip = zipcode
                                annotation.phonenumber = phonenumber
                                self.vCLocations.addObject(annotation)
                                println("VC TYPE: \(table)")
                            case "vh":
                                var title = "VA Hospital"
                                var coord       = CLLocationCoordinate2DMake(lat, lon)
                                var radius = CLLocation(latitude: lat as CLLocationDegrees, longitude: lon as CLLocationDegrees)
                                var annotation  = PinPointAnnotation(coordinate: coord, title: title, subtitle: subtitle, image: UIImage(named: "vaRadius")!, type: table)
                                annotation.city = city
                                annotation.street = street
                                annotation.state = state
                                annotation.zip = zipcode
                                annotation.phonenumber = phonenumber
                                self.vHLocations.addObject(annotation)
                                if((self.defaults.valueForKey(self.showRadiusKeyConstant) as! Bool)) {
                                    self.addRadiusCircle(radius)
                                }
                                println("VH TYPE: \(table)")
                            default:
                                println("nothing")
                            }
                        }
                        
                        switch table {
                        case "fc":
                            self.mapView.addAnnotations(self.hFLocations as [AnyObject])
                        case "md":
                            self.mapView.addAnnotations(self.hMLocations as [AnyObject])
                        case "vc":
                            self.mapView.addAnnotations(self.vCLocations as [AnyObject])
                        case "vh":
                            self.mapView.addAnnotations(self.vHLocations as [AnyObject])
                        default:
                            println("nothing")
                        }
                        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
                    } else if(status as! NSInteger == 400) {
                        /*
                        var alert = UIAlertController(title: "Error", message: "No results returned.", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                        */
                        return
                    }
                })
            })
            networkTask.resume()
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var locValue:CLLocationCoordinate2D = manager.location.coordinate
        if !searchBool {
            self.userLat = locValue.latitude
            self.userLng = locValue.longitude
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func showLocation(sender: AnyObject) {
        var manager = CLLocationManager()
        
        var locValue:CLLocationCoordinate2D = manager.location.coordinate
        let center = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        self.mapView.setRegion(region, animated: true)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (self.oldControllerBool) {
            oldController.dismissViewControllerAnimated(true, completion: {})
        }
        let popoverViewController = segue.destinationViewController as! UIViewController
        popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
        popoverViewController.popoverPresentationController!.delegate = self
        
        self.oldController = popoverViewController
        self.oldControllerBool = true
        
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        if annotation is PinPointAnnotation {
            
            var pp = annotation as! PinPointAnnotation
            
            let identifier = "pinCustom:\(pp.type)"
            var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
            if pinView == nil {
                println("Pinview was nil")
                
                //Create a plain MKAnnotationView if using a custom image...
                pinView = MKAnnotationView(annotation: pp, reuseIdentifier: identifier)
                
                pinView!.canShowCallout = true
                pinView!.rightCalloutAccessoryView = UIButton.buttonWithType(.InfoDark) as! UIButton
                pinView!.image = pp.image
            }
            else {
                //Unrelated to the image problem but...
                //Update the annotation reference if re-using a view...
                pinView.annotation = pp
            }
            
            return pinView
        }
        return nil
    }
    
    func mapView(mapView: MKMapView!, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == annotationView.rightCalloutAccessoryView {
            self.performSegueWithIdentifier("MAPDETAIL", sender: self)
        }
    }
    
    func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
        if(view.annotation.isKindOfClass(PinPointAnnotation))
        {
            var pp = view.annotation as! PinPointAnnotation
            // save data to Storage.. temp fix
            defaults.setObject(pp.title as NSString, forKey: "ppTitle") // Hospital name
            defaults.setObject(pp.subtitle as NSString, forKey: "ppSub") // Hospital location in city, state, zipcode format
            defaults.setObject(pp.type as NSString, forKey: "ppType") // Hospital type (vc, vh, fc, md)
            switch pp.type {
            case "md":
                defaults.setObject(pp.network, forKey: "ppNetwork")
                defaults.setObject(pp.networkType, forKey: "ppNetworkType")
            case "fc":
                defaults.setObject(pp.networkType, forKey: "ppNetworkType")
            default:
                println("Nothing")
            }
            defaults.setObject(pp.city, forKey: "ppCity")
            defaults.setObject(pp.street, forKey: "ppStreet")
            defaults.setObject(pp.state, forKey: "ppState")
            defaults.setObject(pp.zip, forKey: "ppZip")
            defaults.setObject(pp.phonenumber, forKey: "ppPhone")
            defaults.setObject(pp.coordinate.latitude as Double, forKey: "ppCoordLat")
            defaults.setObject(pp.coordinate.longitude as Double, forKey: "ppCoordLng")
            
        }
    }
    
    @IBAction func mapZoom(sender: UIStepper) {
        if((self.zoomLevelValue == 1) && ((sender.value as Double) == 0.05)) {
            sender.stepValue = 1
            self.zoomLevelValue = 0
            println("Zoom level step called")
            self.centerSearch = CLLocationCoordinate2D(latitude: self.mapView.centerCoordinate.latitude, longitude: self.mapView.centerCoordinate.longitude)
            self.regionSearch = MKCoordinateRegion(center: self.centerSearch!, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
            self.mapView.setRegion(self.regionSearch!, animated: true)
            self.regionSearch = MKCoordinateRegion(center: self.centerSearch!, span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2))
            self.mapView.setRegion(self.regionSearch!, animated: true)
        } else if((sender.value as Double) < 0.9)
        {
            sender.stepValue = 1
        } else if((sender.value as Double) > 0.9) {
            sender.stepValue = 1.2
        }
        if((self.zoomLevelValue == 0)) {
            self.centerSearch = CLLocationCoordinate2D(latitude: self.mapView.centerCoordinate.latitude, longitude: self.mapView.centerCoordinate.longitude)
            self.regionSearch = MKCoordinateRegion(center: self.centerSearch!, span: MKCoordinateSpan(latitudeDelta: sender.value, longitudeDelta: sender.value))
            self.mapView.setRegion(self.regionSearch!, animated: true)
        }
        println(sender.value)
        
    }
    
    
    @IBAction func mapSlideZoom(sender: UISlider) {
        var distance : Double = Double(sender.value)
        self.centerSearch = CLLocationCoordinate2D(latitude: self.mapView.centerCoordinate.latitude, longitude: self.mapView.centerCoordinate.longitude)
        self.regionSearch = MKCoordinateRegion(center: self.centerSearch!, span: MKCoordinateSpan(latitudeDelta: distance, longitudeDelta: distance))
        self.mapView.setRegion(self.regionSearch!, animated: true)
        
    }
    
    func addRadiusCircle(location: CLLocation){
        self.mapView.delegate = self
        var circle = MKCircle(centerCoordinate: location.coordinate, radius: 64373.8 /* 40 miles */ as CLLocationDistance)
        self.mapView.addOverlay(circle)
    }
    
    func removeRadiusCircle(){
        if(self.mapView.overlays.count > 0) {
            self.mapView.removeOverlays(self.mapView.overlays!)
        }
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if overlay is MKCircle {
            var circle = MKCircleRenderer(overlay: overlay)
            circle.strokeColor = UIColor.blueColor()
            circle.fillColor = UIColor(red: 0, green: 0, blue: 255, alpha: 0.1)
            circle.lineWidth = 1
            return circle
        } else {
            return nil
        }
    }
}