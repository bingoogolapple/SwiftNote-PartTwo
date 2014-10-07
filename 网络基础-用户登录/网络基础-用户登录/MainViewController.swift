//
//  MainViewController.swift
//  网络基础-用户登录
//
//  Created by bingoogol on 14/9/20.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

/*
网络请求的步骤
1.确定地址NSURL
2.简历请求NSURLRequest
3.建立并启动连接NSURLConnection
4.通过代理方法处理网络请求

*/
class MainViewController: UIViewController,NSURLConnectionDataDelegate {
    var usernameTv:UITextField!
    var passwordTv:UITextField!
    // 从服务器接收的完成数据
    var serverData:NSMutableData!
    
    let baseUrlString = "http://localhost:7777/swift/login"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        var array = NSMutableArray(capacity: 4)
        // 连个Label
        for i in 0 ... 1 {
            var label = UILabel(frame: CGRectMake(20, CGFloat(20 + i * 40), 80, 40))
            self.view.addSubview(label)
            array.addObject(label)
        }
        // 两个TextField
        for i in 0 ... 1 {
            var textField = UITextField(frame: CGRectMake(110, CGFloat(20 + i * 45), 200, 35))
            textField.borderStyle = UITextBorderStyle.RoundedRect
            textField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
            self.view.addSubview(textField)
            array.addObject(textField)
        }
        // 设置Label
        (array[0] as UILabel).text = "用户名："
        (array[1] as UILabel).text = "密    码："
        
        self.usernameTv = array[2] as UITextField
        self.usernameTv.placeholder = "请输入用户名"
        self.passwordTv = array[3] as UITextField
        self.passwordTv.placeholder = "请输入密码"
        self.passwordTv.secureTextEntry = true
        
        
        var getLoginBtn = UIButton.buttonWithType(UIButtonType.System) as UIButton
        getLoginBtn.frame = CGRectMake(80, 110, 200, 30)
        getLoginBtn.setTitle("GET登录", forState: UIControlState.Normal)
        getLoginBtn.addTarget(self, action: Selector("getLogin"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(getLoginBtn)
        
        
        var postLoginBtn = UIButton.buttonWithType(UIButtonType.System) as UIButton
        postLoginBtn.frame = CGRectMake(80, 150, 200, 30)
        postLoginBtn.setTitle("POST登录", forState: UIControlState.Normal)
        postLoginBtn.addTarget(self, action: Selector("postLogin"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(postLoginBtn)
        
        var syncLoginBtn = UIButton.buttonWithType(UIButtonType.System) as UIButton
        syncLoginBtn.frame = CGRectMake(80, 190, 200, 30)
        syncLoginBtn.setTitle("同步登录", forState: UIControlState.Normal)
        syncLoginBtn.addTarget(self, action: Selector("syncLogin"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(syncLoginBtn)

        var asyncLoginBtn = UIButton.buttonWithType(UIButtonType.System) as UIButton
        asyncLoginBtn.frame = CGRectMake(80, 230, 200, 30)
        asyncLoginBtn.setTitle("异步登录", forState: UIControlState.Normal)
        asyncLoginBtn.addTarget(self, action: Selector("asyncLogin"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(asyncLoginBtn)
    }

    func asyncLogin() {
        println("异步登录")
        var username = self.usernameTv.text
        var password = self.passwordTv.text
        var url = NSURL(string: baseUrlString)
        var request = NSMutableURLRequest(URL: url)
        // 同步操作需要设定超时时间
        request.timeoutInterval = 5
        // 请求方式
        request.HTTPMethod = "POST"
        // 数据体,POST请求中创建数据体时，如果有中文，不需要转换，因为dataUsingEncoding时已经实现了转码
        var bodyStr = "username=\(username)&password=王浩\(password)"
        var body = bodyStr.dataUsingEncoding(NSUTF8StringEncoding)
        println("body:\(body)")
        request.HTTPBody = body
        
        
        var error : NSError?
        var response : NSURLResponse?
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (resp:NSURLResponse!, data:NSData!, error:NSError!) -> Void in
            if data != nil {
                self.handleResult(data)
            } else if error == nil {
                println("接收到空数据")
            } else {
                println("请求出错\(error?.localizedDescription)")
            }
        }
    }

    
    func syncLogin() {
        println("同步登录")
        var username = self.usernameTv.text
        var password = self.passwordTv.text
        var url = NSURL(string: baseUrlString)
        var request = NSMutableURLRequest(URL: url)
        // 同步操作需要设定超时时间
        request.timeoutInterval = 5
        // 请求方式
        request.HTTPMethod = "POST"
        // 数据体,POST请求中创建数据体时，如果有中文，不需要转换，因为dataUsingEncoding时已经实现了转码
        var bodyStr = "username=\(username)&password=王浩\(password)"
        var body = bodyStr.dataUsingEncoding(NSUTF8StringEncoding)
        println("body:\(body)")
        request.HTTPBody = body
        
        
        var error : NSError?
        var response : NSURLResponse?
        var urlData = NSURLConnection.sendSynchronousRequest(request,returningResponse: &response,error: &error)
        // 1》接收到数据，表示正常工作
        // 2》没有接收到数据，但是error为nil，表示接收到空数据
        // 3》error不为空，表示请求出错
        if urlData != nil {
            handleResult(urlData!)
        } else if error == nil {
            println("接收到空数据")
        } else {
            println("请求出错\(error?.localizedDescription)")
        }
    }
    
    func getLogin() {
        println("get登录")
        var username = self.usernameTv.text
        var password = self.passwordTv.text
        var urlString = "\(baseUrlString)?username=\(username)&password=\(password)"
        // 提示：get请求时，url中如果包含中文字符需要转换成带%格式
        urlString = urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        println(urlString)
        var url = NSURL(string: urlString)
        // var request = NSURLRequest(URL: url)
        var request = NSURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 3)
        
        var conn = NSURLConnection(request: request, delegate: self)
        // 启动连接，异步请求
        conn.start()
    }
    
    func postLogin() {
        println("post登录")
        var username = self.usernameTv.text
        var password = self.passwordTv.text
        var url = NSURL(string: baseUrlString)
        var request = NSMutableURLRequest(URL: url)
        request.timeoutInterval = 3
        // 请求方式
        request.HTTPMethod = "POST"
        // 数据体,POST请求中创建数据体时，如果有中文，不需要转换，因为dataUsingEncoding时已经实现了转码
        var bodyStr = "username=\(username)&password=王浩\(password)"
        var body = bodyStr.dataUsingEncoding(NSUTF8StringEncoding)
        println("body:\(body)")
        request.HTTPBody = body
        var conn = NSURLConnection(request: request, delegate: self)
        // 启动连接，异步请求
        conn.start()
        
    }
    
    // 1.接收到服务器的响应，服务器要传数据，客户端做接收准备
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        println("didReceiveResponse-准备接收")
        self.serverData = NSMutableData()
    }
    // 2.接收服务器传输的数据，可能会多次执行
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        // 对每次传输的数据进行拼接
        println("didReceiveData-正在接收")
        self.serverData.appendData(data)
    }
    // 3.接收数据完成，做后续处理
    func connectionDidFinishLoading(connection: NSURLConnection) {
        // 对方法2拼接的数据做后续处理
        println("connectionDidFinishLoading-接收完成")
        
        handleResult(serverData)
        // 清空数据
        self.serverData = nil
    }
    // 4.服务器请求失败，原因很多（网络环境等等）
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        println("didFailWithError-请求失败:" + error.localizedDescription)
    }
    // 5.向服务器发送数据，此方法仅适用于POST，尤其上传文件
    func connection(connection: NSURLConnection, didSendBodyData bytesWritten: Int, totalBytesWritten: Int, totalBytesExpectedToWrite: Int) {
        println("didSendBodyData")
    }
    
    
    
    func handleResult(data:NSData) {
        var str = NSString(data: data, encoding: NSUTF8StringEncoding)
        println("服务器返回结果:\(str)")
        // 对服务器返回的字符串进行处理
        var range = str.rangeOfString("用户名")
        var msg:NSString
        if range.length > 0 {
            println("\(NSStringFromRange(range))")
            //服务器返回结果:用户代号:2:用户名swift
            //{7, 3}
            
            var name = str.substringFromIndex(range.location + range.length)
            msg = "欢迎：\(name)"
        } else {
            // 提示：在登录错误时，千万不要告诉用户哪个错了！
            msg = "用户名或密码错误，请重试！"
        }
        var alertView = UIAlertView(title: "提示", message: msg, delegate: nil, cancelButtonTitle: "确定")
        alertView.show()
    }
}