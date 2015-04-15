//
//  PinPoint.swift
//  Veteran Care Network
//
//  Created by Jamone Alexander Kelly on 3/4/15.
//  Copyright (c) 2015 Veteran Care Network, LLC. All rights reserved.
//

import UIKit
import MapKit

class PinPointAnnotation : NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String
    var subtitle: String
    var image : UIImage
    var type : String
    var street : String?
    var state : String?
    var zip : String?
    var city : String?
    var phonenumber : String?
    var network : String?
    var networkType : String?
    
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String, image: UIImage, type: String) {
        self.coordinate = coordinate
        self.title = title!
        self.subtitle = subtitle
        self.image = image
        self.type = type
    }
}