//
//  MainViewController.swift
//  UIWebView
//
//  Created by bingoogol on 14/9/20.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit
/*
webview加载本地文件可以使用加载数据的方式
1.本地文件对应的数据
2.mimetype
3.编码格式字符串
4.相对地址，一般加载本地文件不使用，可以在制定的baseUrl中查找相关文件

如果要用UIWebView显示对应的文件，必须知道准确的MIMEType
但是，不是所有格式的文件都可以通过本地数据的方式加载，即便是知道MIMEType
*/
class MainViewController: UIViewController {
    var webview:UIWebView?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        loadRequest()
    }
    
    func loadRequest() {
        //本地文件 req方式1
        //var path = NSBundle.mainBundle().pathForResource("关于.docx", ofType: nil)
        //var url = NSURL(fileURLWithPath: path!)
        
        // 本地文件 req方式2
       // var url = NSBundle.mainBundle().URLForResource("iOS6Cookbook.pdf", withExtension: nil)
        
        
        var url = NSURL(string: "http://localhost:7777/swift/download/docs")
        var req = NSURLRequest(URL: url)
        webview?.loadRequest(req)
    }
    
    
    func loadHtmlString() {
        webview?.loadHTMLString("<input>", baseURL: nil)
    }
    
    func loadDocx() {
        var path = NSBundle.mainBundle().pathForResource("关于.docx", ofType: nil)
        var url = NSURL(fileURLWithPath: path!)
        var type = mimeType(url)
        println("\(type)")
        webview?.loadData(NSData(contentsOfFile: path!), MIMEType: "application/vnd.openxmlformats-officedocument.wordprocessingml.document", textEncodingName: "UTF-8", baseURL: nil)
    }

    
    
    func loadPdf() {
        var path = NSBundle.mainBundle().pathForResource("iOS6Cookbook.pdf", ofType: nil)
        var url = NSURL(fileURLWithPath: path!)
        var type = mimeType(url)
        println("\(type)")
        webview?.loadData(NSData(contentsOfFile: path!), MIMEType: "application/pdf", textEncodingName: "UTF-8", baseURL: nil)
    }

    
    func loadText() {
        var path = NSBundle.mainBundle().pathForResource("关于.txt", ofType: nil)
        var url = NSURL(fileURLWithPath: path!)
        var type = mimeType(url)
        println("\(type)")
        webview?.loadData(NSData(contentsOfFile: path!), MIMEType: "text/plain", textEncodingName: "UTF-8", baseURL: nil)
    }
    
    func loadHtml() {
        var path = NSBundle.mainBundle().pathForResource("demo.html", ofType: nil)
        var url = NSURL(fileURLWithPath: path!)
        var type = mimeType(url)
        println("\(type)")
        webview?.loadData(NSData(contentsOfFile: path!), MIMEType: "text/html", textEncodingName: "UTF-8", baseURL: nil)
    }
    
    func setupUI() {
        webview = UIWebView(frame: self.view.bounds)
        webview?.dataDetectorTypes = UIDataDetectorTypes.All
        self.view.addSubview(webview!)
    }

    func mimeType(url:NSURL) -> NSString {
        var req = NSURLRequest(URL: url)
        var resp:NSURLResponse?
        NSURLConnection.sendSynchronousRequest(req, returningResponse: &resp, error: nil)
        return resp!.MIMEType!
    }
}