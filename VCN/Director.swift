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
    
    @IBOutlet var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var textV = "Anthony Patterson is a native of Greensboro, North Carolina and has lived there since birth in 1980.  Anthony is the majority owner of Veteran Care Network, LLC (VCN).  He is also the Director/ Majority Owner of United Living, LLC (UL).  Established in 2003, UL is a mental health agency that services adults facing challenges due to intellectual/developmental disability (I/DD) or autism.\n\n Prior to exploring entrepreneurship, Anthony served 3 years in the US Army as a 13 Bravo Cannon Crew Member from 2000-2003. During this 3-year period, he also served a 6-month tour in Kosovo as part of the continuing peacekeeping efforts between Serbia and Albania.  Anthony received the NATO Medal, National Defense Service Medal, and Kosovo Campaign Medal for his role in the peacekeeping mission.\n\n  Along with his entrepreneurial pursuits, Anthony is earning a Bachelor of Science degree in Psychology with minors in Criminal Justice, Strategic Intelligence, and Homeland Security at Liberty University, VA. He will graduate in December 2015.\n\n Anthony embodies discipline, hard work, and dedication. He balances his academic and professional commitments through engaging with his community in multiple ways, including volunteering once a month, donating to the local the YMCA, and participating in various charity runs at least twice a year."
        
        let image = UIImage(named: "anthony") // Load our image asset of Anthony
        let imageView = UIImageView(frame: CGRect(x: 1, y: 8, width: 95, height: 170))
        imageView.image = image
        let path = UIBezierPath(rect: CGRectMake(0, 0, imageView.frame.width, imageView.frame.height)) // Needed for words to wrap around image of Anthony
        text = UITextView(frame: CGRect(x: 1, y: 1, width: self.view.frame.width, height: 380))
        text.text = textV
        text.textContainer.exclusionPaths = [path] // Add path to UITextView
        text.editable = false // Disable editing
        text.selectable = false // Disable highlighting/selecting of text
        text.scrollEnabled = true
        text.userInteractionEnabled = true
        text.addSubview(imageView) // Add the image to the UITextView
        text.clipsToBounds = true
        scrollView.addSubview(text)
        
        let arrow = UIImage(named: "rightarrow")
        let arrview = UIImageView(image: arrow)
        arrview.frame = CGRect(x: (self.view.frame.width/2)-40, y: 382, width: 50, height: 50)
        scrollView.addSubview(arrview)
        
        let label = UILabel(frame: CGRect(x: (self.view.frame.width/2)-40, y: 415, width: 120, height: 50))
        label.numberOfLines = 2
        label.text = "Swipe right"
        scrollView.addSubview(label)
    }
}
