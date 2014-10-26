//
//  ViewController.swift
//  断点续传思路
//
//  Created by bingoogol on 14/10/26.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.download()
    }
    
    func download() {
        // 1. NSURL
        var url = NSURL(string:"http://localhost/~apple/itcast/download/iTunesConnect_DeveloperGuide_CN.zip");
        
        // 2. NSURLRequest
        // 要判断网络服务器上文件的大小，可以使用HTTP的HEAD方法
        var request = NSMutableURLRequest(URL: url!)
        
        // 使用HEAD方法，仅获取目标文件的信息，而不做实际的下载工作
        //    [request setHTTPMethod:@"HEAD"];
        
        /**
        实现断点续传的思路
        
        HeaderField：头域（请求头部的字段）
        
        可以通过指定rangge的范围逐步地下载指定范围内的数据，待下载完成后，再将这些数据拼接成一个文件
        */
        
        request.setValue("bytes=6100000-",forHTTPHeaderField:"range");
        
        // 3. NSURLConnection
        // 如果要获取文件长度，可以在Response中获取到
        var response:NSURLResponse?
        
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: nil)
        
        // 在response的expectedContentLength属性中可以获知要下载文件的文件长度
        NSLog("%lld %d", response!.expectedContentLength, data!.length);
    }

}