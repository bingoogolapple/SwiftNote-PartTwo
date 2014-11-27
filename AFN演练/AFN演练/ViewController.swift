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
    
    /**
    检测联网状态
    */
    @IBAction func reachability() {
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
    
    @IBAction func loadJSON() {
        let manager = AFHTTPRequestOperationManager()
        manager.GET("",
            parameters: nil,
            success: { (operation:AFHTTPRequestOperation!, responseObject:AnyObject!) in
                println("success")
            },
            failure: { (operation:AFHTTPRequestOperation!, error:NSError!) in
                println("")
            }
        )
    }
    
    
    @IBAction func loadXML() {
        
    }
    
}