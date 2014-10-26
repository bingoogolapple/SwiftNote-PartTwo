//
//  ViewController.swift
//  网络基础-上传文件
//
//  Created by bingoogol on 14/10/26.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    weak var imageView:UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        var image = UIImage(named: "头像1.png")
        var imageView = UIImageView(image: image)
        imageView.frame = CGRectMake(60, 20, 200, 200)
        self.view.addSubview(imageView)
        self.imageView = imageView
        
        var button = UIButton.buttonWithType(UIButtonType.System) as UIButton
        button.frame = CGRectMake(60, 240, 200, 40)
        button.setTitle("upload", forState: UIControlState.Normal)
        button.addTarget(self, action: Selector("uploadImage"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
    }
    
    func uploadImage() {
        println("uploadImage")
        // 思路：是需要使用HTTP的POST方法上传文件
        // 调用的URL是http://localhost:8080/swift/upload
        // 数据体的参数名：file
        
        // 1.建立NSURL
        var url = NSURL(string: "http://localhost:8080/swift/upload")
        // 2.建立NSMutableRequest
        var request = NSMutableURLRequest(URL: url!)
        // 1)设置request的属性，设置方法
        request.HTTPMethod = "POST"
        // 2)设置数据体
        // 1> 设置boundary的字符串，以便复用
        var boundary = "uploadBoundary";
        // 2> 头部字符串
        var startStr = NSMutableString();
        startStr.appendString("--\(boundary)\n")
        startStr.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"upload.png\"\n")
        startStr.appendString("Content-Type: image/png\n\n")
        
        // 3> 尾部字符串
        var endStr = NSMutableString()
        endStr.appendString("--\(boundary)\n")
        endStr.appendString("Content-Disposition: form-data; name=\"submit\"\n\n")
        endStr.appendString("Submit\n")
        endStr.appendFormat("--\(boundary)--")
        
        // 4> 拼接数据体
        var bodyData = NSMutableData()
        bodyData.appendData(startStr.dataUsingEncoding(NSUTF8StringEncoding)!)
        
        var imageData = UIImagePNGRepresentation(self.imageView.image);
        bodyData.appendData(imageData)
        
        bodyData.appendData(endStr.dataUsingEncoding(NSUTF8StringEncoding)!)
        
        request.HTTPBody = bodyData
        
        // 5> 指定Content-Type，在上传文件时，需要指定Content-Type & Content-Length
        var contentStr = "multipart/form-data; boundary=\(boundary)"
        request.setValue(contentStr, forHTTPHeaderField: "Content-Type")
        
        // 6> 指定Content-Length
        var length = bodyData.length;
        request.setValue("\(length)", forHTTPHeaderField: "Content-Length")
        
        // 3.使用NSURLConnection的同步方法上传文件，因为需要用户确认上传文件是否上传成功！
        //  在使用HTTP上传文件时，通常是有大小限制的
        var response:NSURLResponse?
        var error:NSError?
        var resultData = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        var resultStr = NSString(data: resultData!, encoding: NSUTF8StringEncoding)
        println(resultStr)
    }

}