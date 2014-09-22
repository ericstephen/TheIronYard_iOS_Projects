//
//  ViewController.swift
//  FreeWithAd
//
//  Created by Eric Williams on 9/22/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

import UIKit
import iAd

class ViewController: UIViewController, ADBannerViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.canDisplayBannerAds = true  /// GETTING iADs into your APP ///
        
        var bannerView = ADBannerView()
        bannerView.delegate = self
        self.view.addSubview(bannerView)
        
        var bannerView1 = ADBannerView()
        bannerView1.center = CGPointMake(bannerView1.center.x, UIScreen.mainScreen().bounds.size.height - (bannerView1.frame.size.height / 2.0))
        bannerView1.delegate = self
        self.view.addSubview(bannerView1)
    }
}

