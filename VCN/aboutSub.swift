//
//  aboutSub.swift
//  Veteran Care Network
//
//  Created by Jamone Alexander Kelly on 4/19/15.
//  Copyright (c) 2015 Veteran Care Network, LLC. All rights reserved.
//

import UIKit

class aboutSub: UIViewController {
    var textView : UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var text = "VCN (Veteran Care Network) is a \"non-governmental\" veteran owned and operated veteran service organization formed to provide information on facilities and organizations nationwide that provide various levels of health care for veterans and their families, inside and outside of VA medical facilities. This service is extremely beneficial to ensure timely and competent health care for veterans nationwide and accomplishes a number of the goals set forth by the Veterans Access, Choice and Accountability Act of 2014.\n\n" +
        
       "Specifically the goal of enabling veterans to have access to health care facilities outside of the VA system is made much easier because of our mobile app.\n\n"
        +
        "We provide the name, address, phone number and type of facility for over 18,000 governmental  and  civilian health care locations. This information is obtain by going direct to our \"Veteran Medical Services\" online map from a PC or using our VCN mobile APP, which is compatible with both IOS and Android mobile devices.\n\n"
        +
        "This APP will drastically reduce or eliminate the frustration and wasted time experienced when it comes to finding services and treatment for veterans and their family. With the distribution of the new \"Choice Cards\", veterans who live at least 40 miles from a VA hospital, or who must travel by air, boat or ferry to access VA care, will be able to find the nearest approved non-government medical care facility. This feature will make healthcare more accessible and treatment more timely, which accomplishes the main goal of theVeterans Access, Choice and Accountability Act of 2014.\n\n"
        +
       "In addition, we also offer live support in assisting veterans in locating the closest and most appropriate facility if they reside at least 40 miles away from a VA medical facility.\n\n"
        +
        "It is our goal to break the cycle of medical maltreatment and callous apathy shown to veterans and their families. When the power of choice is put into the hands of those who need medical service, as it should have always been, the level and quality of medical care is not only improved, proper and expedient medical care becomes a reality.\n\n"
        textView = UITextView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width-20, height: 400))
        textView.text = text
        textView.editable = false
        textView.selectable = false
        textView.userInteractionEnabled = true
        textView.scrollEnabled = true
        self.view.addSubview(textView)
        
        //textView.sizeToFit()
        //textView.layoutIfNeeded()
        
        var frame : CGRect = textView.frame
        frame.size.height = textView.contentSize.height
        textView.frame = frame
        
        self.textView.layoutManager.allowsNonContiguousLayout = false
        //self.view.updateConstraintsIfNeeded()
        println("Frame Width: \(self.view.frame.width) Height: \(self.view.frame.height)")
    }
}
