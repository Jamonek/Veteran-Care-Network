//
//  MapDetail.swift
//  Veteran Care Network
//
//  Created by Jamone Alexander Kelly on 3/23/15.
//  Copyright (c) 2015 Veteran Care Network, LLC. All rights reserved.
//  http://jamonek.com
//  http://veterancarenetwork.com
//

import UIKit
import CoreLocation
import MapKit

class MapDetail :  UITableViewController, UITableViewDataSource {
    
    @IBOutlet var tableViewData: UITableView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var type: UILabel!
    @IBOutlet var owner: UILabel!
    @IBOutlet var directionsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Medical Facility View"
        
        tableViewData.delegate = self
        tableViewData.dataSource = self
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let defaults = NSUserDefaults.standardUserDefaults()
        if((defaults.valueForKey("ppType") as! NSString) == "fc") { // Based on the selected facility type, determine number of cells to display
            return 5
        } else if((defaults.valueForKey("ppType") as! NSString) == "md") {
            return 6
        } else {
            return 3
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        let defaults = NSUserDefaults.standardUserDefaults()
        let cell = UITableViewCell()
        cell.userInteractionEnabled = true
        cell.setHighlighted(false, animated: true)
        cell.setEditing(false, animated: true)
        var label = UILabel(frame: CGRect(x:70, y:0, width:250, height:60))
        label.numberOfLines = 0
        var directionButton = UIButton(frame: CGRect(x: 70, y: 0, width: 90, height: 50))
        directionButton.userInteractionEnabled = true
        directionButton.backgroundColor = UIColor.clearColor()
        directionButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        directionButton.setTitle("Directions", forState: UIControlState.Normal)
        directionButton.addTarget(self, action: "openDirectionsInMapApp:", forControlEvents: UIControlEvents.TouchUpInside)
        directionButton.tag = indexPath.row
        let streetAddress1 = defaults.valueForKey("ppStreet") as! NSString
        let streetAddress2 = defaults.valueForKey("ppSub") as! NSString
        let streetAddress = "\(streetAddress1.capitalizedString)\n\(streetAddress2)"
        var image : UIImage!
        var imageView : UIImageView!
        
        if((defaults.valueForKey("ppType") as! NSString) == "fc") {
            switch indexPath.item {
            case 0:
                image = UIImage(named: "contact-name")
                imageView = UIImageView(image: image)
                imageView.frame = CGRect(x: 10, y: 6, width: 44, height: 44)
                cell.addSubview(imageView)
                label.text = (defaults.valueForKey("ppTitle") as! NSString).capitalizedString
                label.fadeIn(duration: 10.0, delay: 4.0)
                cell.addSubview(label)
            case 1:
                image = UIImage(named: "location-2way")
                imageView = UIImageView(image: image)
                imageView.frame = CGRect(x: 10, y: 6, width: 44, height: 44)
                cell.addSubview(imageView)
                label.text = streetAddress
                label.fadeIn(duration: 10.0, delay: 4.0)
                cell.addSubview(label)
            case 2:
                image = UIImage(named: "next")
                imageView = UIImageView(image: image)
                imageView.frame = CGRect(x: 10, y: 6, width: 44, height: 44)
                cell.addSubview(imageView)
                label.text = defaults.valueForKey("ppNetworkType") as! NSString as String
                label.fadeIn(duration: 10.0, delay: 4.0)
                cell.addSubview(label)
            case 3:
                image = UIImage(named: "phone")
                imageView = UIImageView(image: image)
                imageView.frame = CGRect(x: 10, y: 6, width: 44, height: 44)
                cell.addSubview(imageView)
                let phoneNumberTextView = UITextView(frame: CGRect(x: 70, y: 0, width: 300, height: 60))
                phoneNumberTextView.text = defaults.valueForKey("ppPhone") as! NSString as String
                phoneNumberTextView.dataDetectorTypes = UIDataDetectorTypes.PhoneNumber
                phoneNumberTextView.editable = false
                phoneNumberTextView.font = UIFont.boldSystemFontOfSize(22)
                cell.addSubview(phoneNumberTextView)
            case 4:
                image = UIImage(named: "location-globe")
                imageView = UIImageView(image: image)
                imageView.frame = CGRect(x: 10, y: 6, width: 44, height: 44)
                cell.addSubview(imageView)
                cell.addSubview(directionButton)
            default:
                println("Nothing")
            }
        } else if((defaults.valueForKey("ppType") as! NSString) == "md") {
            switch indexPath.item {
            case 0:
                image = UIImage(named: "contact-name")
                imageView = UIImageView(image: image)
                imageView.frame = CGRect(x: 10, y: 6, width: 44, height: 44)
                cell.addSubview(imageView)
                label.text = (defaults.valueForKey("ppTitle") as! NSString).capitalizedString
                label.fadeIn(duration: 10.0, delay: 4.0)
                cell.addSubview(label)
            case 1:
                image = UIImage(named: "location-2way")
                imageView = UIImageView(image: image)
                imageView.frame = CGRect(x: 10, y: 6, width: 44, height: 44)
                cell.addSubview(imageView)
                label.text = streetAddress
                label.fadeIn(duration: 10.0, delay: 4.0)
                cell.addSubview(label)
            case 2:
                image = UIImage(named: "next")
                imageView = UIImageView(image: image)
                imageView.frame = CGRect(x: 10, y: 6, width: 44, height: 44)
                cell.addSubview(imageView)
                label.text = defaults.valueForKey("ppNetwork") as! NSString as String
                label.fadeIn(duration: 10.0, delay: 4.0)
                cell.addSubview(label)
            case 3:
                image = UIImage(named: "next")
                imageView = UIImageView(image: image)
                imageView.frame = CGRect(x: 10, y: 6, width: 44, height: 44)
                cell.addSubview(imageView)
                label.text = defaults.valueForKey("ppNetworkType") as! NSString as String
                label.fadeIn(duration: 10.0, delay: 4.0)
                cell.addSubview(label)
            case 4:
                image = UIImage(named: "phone")
                imageView = UIImageView(image: image)
                imageView.frame = CGRect(x: 10, y: 6, width: 44, height: 44)
                cell.addSubview(imageView)
                let phoneNumberTextView = UITextView(frame: CGRect(x: 70, y: 0, width: 300, height: 60))
                phoneNumberTextView.text = defaults.valueForKey("ppPhone") as! NSString as String
                phoneNumberTextView.dataDetectorTypes = UIDataDetectorTypes.PhoneNumber
                phoneNumberTextView.editable = false
                phoneNumberTextView.font = UIFont.boldSystemFontOfSize(22)
                cell.addSubview(phoneNumberTextView)
            case 5:
                image = UIImage(named: "location-globe")
                imageView = UIImageView(image: image)
                imageView.frame = CGRect(x: 10, y: 6, width: 44, height: 44)
                cell.addSubview(imageView)
                cell.addSubview(directionButton)
            default:
                println("Nothing")
            }
        } else {
            switch indexPath.item {
            case 0:
                image = UIImage(named: "location-2way")
                imageView = UIImageView(image: image)
                imageView.frame = CGRect(x: 10, y: 6, width: 44, height: 44)
                cell.addSubview(imageView)
                label.text = streetAddress
                label.fadeIn(duration: 10.0, delay: 4.0)
                cell.addSubview(label)
            case 1:
                image = UIImage(named: "phone")
                imageView = UIImageView(image: image)
                imageView.frame = CGRect(x: 10, y: 6, width: 44, height: 44)
                cell.addSubview(imageView)
                let phoneNumberTextView = UITextView(frame: CGRect(x: 6, y: 0, width: 300, height: 60))
                phoneNumberTextView.text = defaults.valueForKey("ppPhone") as! NSString as String
                phoneNumberTextView.dataDetectorTypes = UIDataDetectorTypes.PhoneNumber
                phoneNumberTextView.editable = false
                phoneNumberTextView.font = UIFont.boldSystemFontOfSize(22)
                cell.addSubview(phoneNumberTextView)
            case 2:
                image = UIImage(named: "location-globe")
                imageView = UIImageView(image: image)
                imageView.frame = CGRect(x: 10, y: 6, width: 44, height: 44)
                cell.addSubview(imageView)
                cell.addSubview(directionButton)
            default:
                println("Nothing")
            }
        }
        return cell
    }
    
    func openDirectionsInMapApp(sender: UIButton!) {
        println("Directions button pressed")
        let defaults = NSUserDefaults.standardUserDefaults()
        let regionDistance:CLLocationDistance = 10000
        var latitute : CLLocationDegrees = defaults.valueForKey("ppCoordLat") as! CLLocationDegrees
        var longitute : CLLocationDegrees = defaults.valueForKey("ppCoordLng") as! CLLocationDegrees
        var coordinates = CLLocationCoordinate2DMake(latitute, longitute)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        var options = [
            MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: regionSpan.span)
        ]
        var placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        var mapItem = MKMapItem(placemark: placemark)
        mapItem.name = (defaults.valueForKey("ppTitle") as! NSString) as String
        mapItem.phoneNumber = defaults.valueForKey("ppPhone") as! NSString as String
        mapItem.openInMapsWithLaunchOptions(options)
    }
    
    // UITableViewDelegate Functions
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
