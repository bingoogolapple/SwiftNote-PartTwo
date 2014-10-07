//
//  MainViewController.swift
//  UIWebView-浏览器
//
//  Created by bingoogol on 14/9/21.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UITextFieldDelegate {
    
    var webView:UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        // 1.顶部toolbar
        var toolbar = UIToolbar(frame: CGRectMake(0, 20, self.view.bounds.size.width, 44))
        self.view.addSubview(toolbar)
        // 1).textfield可以以UIBarButtonItem的自定义视图的方式加入toolbar
        var textField = UITextField(frame: CGRectMake(10, 6, 200, 32))
        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        // 设置清楚按钮
        textField.clearButtonMode = UITextFieldViewMode.WhileEditing
        textField.delegate = self
        var addressItem = UIBarButtonItem(customView: textField)
        // 2).三个按钮
        var item1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Rewind, target: self, action: Selector("goBack"))
        var item2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FastForward, target: self, action: Selector("goForward"))
        var item3 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: Selector("refresh"))
        toolbar.setItems([addressItem,item1,item2,item3], animated: false)
        // 2.UIWebView
        webView = UIWebView(frame: CGRectMake(0, 64, self.view.bounds.width, self.view.bounds.height - 64))
        self.view.addSubview(webView)
    }
    
    func goBack() {
        println("后退")
        self.webView.goBack()
    }
    
    func goForward() {
        println("前进")
        self.webView.goForward()
    }
    
    func refresh() {
        println("刷新")
        self.webView.reload()
        
        //jsDemo()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        println("回车加载数据")
        // 关闭键盘
        textField.resignFirstResponder()
        // 让webView加载地址栏中的内容
        // 关于字符串的比较，是属于消耗性能较大的，在判断字符串是否有内容时，可以使用长度，这样性能更好，此方法适用于所有编程语言
        if !textField.text.isEmpty {
            self.loadContentWithURLString(textField.text)
        } else {
            println("url空")
        }
        return true
    }
    
    func loadContentWithURLString(urlString:NSString) {
        println("加载content")
        var hasError = false
        if urlString.hasPrefix("http://") {
            self.loadURL(NSURL(string: urlString))
        } else if urlString.hasPrefix("file://") {
            var range = urlString.rangeOfString("file://")
            var filename = urlString.substringFromIndex(range.location + range.length)
            println("filename:\(filename)")
            var url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
            if url == nil {
                println("地址错误1")
                hasError = true
            } else {
                self.loadURL(url!)
            }
        } else {
            println("地址错误2")
            hasError = true
        }
        
        if hasError {
            var alertView = UIAlertView(title: "提示", message: "地址错误", delegate: nil, cancelButtonTitle: "确定")
        }
    }
    
    func loadURL(url:NSURL) {
        var req = NSURLRequest(URL: url)
        self.webView.loadRequest(req)
    }
    
    func jsDemo() {
        self.webView.stringByEvaluatingJavaScriptFromString("document.forms[0].submit();")
    }

}
