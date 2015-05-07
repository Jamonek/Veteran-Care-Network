//
//  About.swift
//  VCN
//
//  Created by Jamone Alexander Kelly on 2/14/15.
//  Copyright (c) 2015 Veteran Care Network, LLC. All rights reserved.
//  http://jamonek.com
//  http://veterancarenetwork.com
//

import UIKit

class About: UIPageViewController ,UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var index = 0
    var ids : NSArray = ["aboutUsNav", "directorNav"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Veteran Care Network" // set navigation title
        self.navigationController?.title = "About" // set tab bar item title
        
        self.dataSource = self
        self.delegate = self
        let startingViewController = self.viewControllerAtIndex(self.index)
        let viewControllers: NSArray = [startingViewController]
        self.setViewControllers(viewControllers as! [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        
        
        
    }
    
    func viewControllerAtIndex(index: Int) -> UINavigationController! {
        println("viewControllerIndex: \(index)")
        //first view controller = firstViewControllers navigation controller
        switch index {
        case 0:
            return self.storyboard!.instantiateViewControllerWithIdentifier("aboutUsNav") as! UINavigationController
        case 1:
            return self.storyboard!.instantiateViewControllerWithIdentifier("directorNav") as! UINavigationController
        default:
            return nil
        }
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    
        let identifier = viewController.restorationIdentifier
        println("After ID: \(identifier!)")
        let index = self.ids.indexOfObject(identifier!)
        println("pageViewControllerAfterPre: \(index as Int) Index: \(self.index)")
        //if the index is the end of the array, return nil since we dont want a view controller after the last one
        if self.index >= 1 {
            
            return nil
        }
        
        //increment the index to get the viewController after the current index
        self.index = self.index + 1
        println("pageViewControllerAfter: \(index as Int) Index: \(self.index)")
        return self.viewControllerAtIndex(self.index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let identifier = viewController.restorationIdentifier
        println("Before ID: \(identifier!)")
        let index = self.ids.indexOfObject(identifier!)
        println("pageViewControllerBeforePre: \(index as Int) Index: \(self.index)")
        //if the index is 0, return nil since we dont want a view controller before the first one
        if self.index <= 0 {
            
            return nil
        }
        
        //decrement the index to get the viewController before the current one
        self.index = self.index - 1
        println("pageViewControllerBefore: \(index as Int) Index: \(self.index)")
        return self.viewControllerAtIndex(self.index)
    }
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        let count = self.ids.count
        println("presentationCount: \(count)")
        return self.ids.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}