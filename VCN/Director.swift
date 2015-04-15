//
//  Director.swift
//  Veteran Care Network
//
//  Created by Jamone Alexander Kelly on 3/27/15.
//  Copyright (c) 2015 Veteran Care Network, LLC. All rights reserved.
//

import UIKit

class Director : UIViewController {
    
    @IBOutlet var text: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "anthony")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 95, height: 200))
        imageView.image = image
        let path = UIBezierPath(rect: CGRectMake(0, 0, imageView.frame.width, imageView.frame.height))
        text.textContainer.exclusionPaths = [path]
        text.editable = false
        text.selectable = false
        text.addSubview(imageView)
    }
}
