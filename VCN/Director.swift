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
    
    var text : UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var textV = "Anthony Patterson is a native of Greensboro, North Carolina and has lived there since birth in 1980.  Anthony is the majority owner of Veteran Care Network, LLC (VCN).  He is also the Director/ Majority Owner of United Living, LLC (UL).  Established in 2003, UL is a mental health agency that service adults facing challenges do to intellectual/developmental disability (I/DD) or autism.  Prior to exploring entrepreneurship opportunities Anthony served 3 years in the US Army as a 13 Bravo Cannon Crew Member from 2000-2003.\n\nDuring his 3 year period he also served a 6 month tour in Kosovo Europe.  The purpose was for the continuing effort of piece keeping between Serbia and Albania.  Anthony received the NATO Medal, National Defense Service Medal, and Kosovo Campaign Medal for his role in the peace keeping mission.  Along with the continuation of entrepreneurship Anthony is also pursuing his Bachelors of Science in Psychology with minors in Criminal Justice, Strategic Intelligence, and Homeland Security at Liberty University, VA.\n\nAnthony embodies elements of discipline, hard work, and dedication which lead to assertive efforts to give back. These efforts include volunteering once a month, donating to the local YMCA, and participating in various charity runs at least twice a year."
        
        let image = UIImage(named: "anthony") // Load our image asset of Anthony
        let imageView = UIImageView(frame: CGRect(x: 1, y: 8, width: 95, height: 170))
        imageView.image = image
        let path = UIBezierPath(rect: CGRectMake(0, 0, imageView.frame.width, imageView.frame.height)) // Needed for words to wrap around image of Anthony
        text = UITextView(frame: CGRect(x: 1, y: 1, width: self.view.frame.width-20, height: 400))
        text.text = textV
        text.textContainer.exclusionPaths = [path] // Add path to UITextView
        text.editable = false // Disable editing
        text.selectable = false // Disable highlighting/selecting of text
        text.scrollEnabled = true
        text.userInteractionEnabled = true
        text.addSubview(imageView) // Add the image to the UITextView
        text.clipsToBounds = true
        self.view.addSubview(text)
        println("Frame Width: \(self.view.frame.width) Height: \(self.view.frame.height)")
    }
}
