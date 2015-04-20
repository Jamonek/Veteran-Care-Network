//
//  Director.swift
//  Veteran Care Network
//
//  Created by Jamone Alexander Kelly on 3/27/15.
//  Copyright (c) 2015 Veteran Care Network, LLC. All rights reserved.
//  http://jamonek.com
//  http://veterancarenetwork.com
//

import UIKit

class Director : UIViewController {
    
    @IBOutlet var text: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("Director called ")
        let image = UIImage(named: "anthony") // Load our image asset of Anthony
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 95, height: 200))
        imageView.image = image
        let path = UIBezierPath(rect: CGRectMake(0, 0, imageView.frame.width, imageView.frame.height)) // Needed for words to wrap around image of Anthony
        text.textContainer.exclusionPaths = [path] // Add path to UITextView
        text.editable = false // Disable editing
        text.selectable = false // Disable highlighting/selecting of text
        text.addSubview(imageView) // Add the image to the UITextView
        //text.layoutIfNeeded()
    }
}
