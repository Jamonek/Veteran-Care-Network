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
    @IBOutlet var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var text = "Veteran Care Network (VCN) is a non-governmental veteran owned and operated service organization formed to provide information to veterans and their families. VCN connects clients to a nationwide list of facilities and organizations that provide various levels of health care, inside and outside of VA medical facilities. This service is extremely beneficial to ensure timely and competent health care for veterans, accomplishing a number of the goals set forth by the Veterans Access, Choice and Accountability Act of 2014.\n\n In addition to the VCN website, our mobile APP allows veterans to have easy access to health care facilities inside and outside of the VA system.\n\n We provide the name, address, phone number and type of facility for over 18,000 governmental and civilian health care locations. This information is obtained by going directly to our \"Veteran Medical Services\" online map in two ways:" + "1. From a PC" + "2. Using our VCN mobile APP, which is compatible with both IOS and Android mobile devices.\n\n" + "This APP will drastically reduce or eliminate the frustration and wasted time experienced when finding services and treatment for veterans and their families. With the distribution of the new \"Choice Cards,\" veterans who live at least 40 miles from a VA hospital, or who must travel by air, boat or ferry to access VA care, will be able to find the nearest approved non-government medical care facility. This feature will make healthcare more accessible and treatment more timely, which accomplishes the main goal of the Veterans Access, Choice and Accountability Act of 2014.\n\n" + "In addition, we offer live support to veterans attempting to locate the closest and most appropriate facility if they reside at least 40 miles from a VA medical facility.\n\n" + "It is our goal to break the cycle of medical maltreatment and callous apathy shown to veterans and their families. When the power of choice is put into the hands of those who need medical service, as it should always be, the level and quality of medical care is not only improved, proper and expedient medical care becomes a reality.\n\n"
        textView = UITextView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 380))
        textView.text = text
        textView.editable = false
        textView.selectable = false
        textView.userInteractionEnabled = true
        textView.scrollEnabled = true
        scrollView.addSubview(textView)
//        self.view.addSubview(textView)
        
        //textView.sizeToFit()
        //textView.layoutIfNeeded()
        
        var frame : CGRect = textView.frame
        frame.size.height = textView.contentSize.height
        textView.frame = frame
        
        self.textView.layoutManager.allowsNonContiguousLayout = false
        //self.view.updateConstraintsIfNeeded()
        
        let arrow = UIImage(named: "leftarrow")
        let arrview = UIImageView(image: arrow)
        arrview.frame = CGRect(x: (self.view.frame.width/2)-40, y: 382, width: 50, height: 50)
        scrollView.addSubview(arrview)
        
        let label = UILabel(frame: CGRect(x: (self.view.frame.width/2)-40, y: 400, width: 130, height: 85))
        label.numberOfLines = 2
        label.text = "Swipe left"
        scrollView.addSubview(label)
    }
}
