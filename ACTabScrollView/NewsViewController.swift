//
//  NewsViewController.swift
//  ACTabScrollView
//
//  Created by AzureChen on 2015/8/19.
//  Copyright (c) 2015年 AzureChen. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, ACTabScrollViewDelegate, ACTabScrollViewDataSource {

    @IBOutlet weak var tabScrollView: ACTabScrollView!
    
    var contentViews: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set ACTabScrollView, all the following properties are optional
        tabScrollView.defaultPage = 3
        tabScrollView.arrowIndicator = true
//        tabScrollView.tabSectionHeight = 40
//        tabScrollView.tabSectionBackgroundColor = UIColor.whiteColor()
//        tabScrollView.contentSectionBackgroundColor = UIColor.whiteColor()
//        tabScrollView.tabGradient = true
//        tabScrollView.pagingEnabled = true
//        tabScrollView.cachedPageLimit = 3
        
        tabScrollView.delegate = self
        tabScrollView.dataSource = self
        
        // create content views from storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        for category in NewsCategory.allValues() {
            let vc = storyboard.instantiateViewControllerWithIdentifier("ContentViewController") as! ContentViewController
            vc.category = category
            
            addChildViewController(vc) // don't forget, it's very important
            contentViews.append(vc.view)
        }
        
        // set navigation bar appearance
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.translucent = false
            navigationBar.tintColor = UIColor.whiteColor()
            navigationBar.barTintColor = UIColor(red: 38.0 / 255, green: 191.0 / 255, blue: 140.0 / 255, alpha: 1)
            navigationBar.titleTextAttributes = NSDictionary(object: UIColor.whiteColor(), forKey: NSForegroundColorAttributeName) as? [String : AnyObject]
            navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            navigationBar.shadowImage = UIImage()
        }
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    }
    
    // MARK: ACTabScrollViewDelegate
    func tabScrollView(tabScrollView: ACTabScrollView, didChangePageTo index: Int) {
        print(index)
    }
    
    func tabScrollView(tabScrollView: ACTabScrollView, didScrollPageTo index: Int) {
    }
    
    // MARK: ACTabScrollViewDataSource
    func numberOfPagesInTabScrollView(tabScrollView: ACTabScrollView) -> Int {
        return NewsCategory.allValues().count
    }
    
    func tabScrollView(tabScrollView: ACTabScrollView, tabViewForPageAtIndex index: Int) -> UIView {
        // create a label
        let label = UILabel()
        label.text = String(NewsCategory.allValues()[index]).uppercaseString
        if #available(iOS 8.2, *) {
            label.font = UIFont.systemFontOfSize(16, weight: UIFontWeightThin)
        } else {
            label.font = UIFont.systemFontOfSize(16)
        }
        label.textColor = UIColor(red: 77.0 / 255, green: 79.0 / 255, blue: 84.0 / 255, alpha: 1)
        label.textAlignment = .Center
        
        // if the size of your tab is not fixed, you can adjust the size by the following way.
        label.sizeToFit() // resize the label to the size of content
        label.frame.size = CGSize(width: label.frame.size.width + 28, height: label.frame.size.height + 36) // add some paddings
        
        return label
    }
    
    func tabScrollView(tabScrollView: ACTabScrollView, contentViewForPageAtIndex index: Int) -> UIView {
        return contentViews[index]
    }
}

