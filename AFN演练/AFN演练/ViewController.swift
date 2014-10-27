//
//  ViewController.swift
//  AFN演练
//
//  Created by bingoogol on 14/10/27.
//  Copyright (c) 2014年 bingoogolapple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func reachability(sender: UIButton) {
        AFNetworkReachabilityManager.sharedManager().startMonitoring()
        AFNetworkReachabilityManager.sharedManager().setReachabilityStatusChangeBlock { (status:AFNetworkReachabilityStatus) in
            switch status {
            case AFNetworkReachabilityStatus.Unknown:
                println("连接状态未知")
            case AFNetworkReachabilityStatus.NotReachable:
                println("无连接")
            case AFNetworkReachabilityStatus.ReachableViaWWAN:
                println("3G连接")
            case AFNetworkReachabilityStatus.ReachableViaWiFi:
                println("WIFI连接")
            }
            AFNetworkReachabilityManager.sharedManager().stopMonitoring()
        }
    }

    
}