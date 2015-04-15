//
//  PinPoint.swift
//  Veteran Care Network
//
//  Created by Jamone Alexander Kelly on 3/4/15.
//  Copyright (c) 2015 Veteran Care Network, LLC. All rights reserved.
//  http://jamonek.com
//  http://veterancarenetwork.com
//

import UIKit
import MapKit

// Our custom MKAnnotation
class PinPointAnnotation : NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D // Annotation coordinate for where to display on map
    var title: String // title of the annotation (hospital name)
    var subtitle: String // subtitle of the annotation (hospital location)
    var image : UIImage // custom annotation pin image based on facility type
    var type : String // facility type
    var street : String? // Street of facility
    var state : String? // State of facility
    var zip : String? // zip of facility
    var city : String? // city of facility
    var phonenumber : String? // phone number of facility
    var network : String? // facility network
    var networkType : String? // facility network type
    
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String, image: UIImage, type: String) {
        self.coordinate = coordinate
        self.title = title!
        self.subtitle = subtitle
        self.image = image
        self.type = type
    }
}