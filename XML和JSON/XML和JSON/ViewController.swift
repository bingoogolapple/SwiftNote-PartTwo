//
//  ViewController.swift
//  XML和JSON
//
//  Created by bingoogol on 14/10/7.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate {
    let CELL_ID = "MyCell"
    var tableView:UITableView!
    var model:Model = Model()
    var dataList:NSMutableArray!
    var elementStr:NSMutableString!
    var currentVideo:Model!
    
    override func loadView() {
        self.view = UIView(frame: UIScreen.mainScreen().bounds)
        var frame = UIScreen.mainScreen().applicationFrame
        tableView = UITableView(frame: CGRectMake(0, frame.origin.y, frame.width, frame.height - 44), style: UITableViewStyle.Plain)!
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        self.view.addSubview(tableView)
        
        var toolBar = UIToolbar(frame: CGRectMake(0, tableView.bounds.height + frame.origin.y, frame.width, 44))
        var item1 = UIBarButtonItem(title: "load JSON", style: UIBarButtonItemStyle.Done, target: self, action: Selector("loadJSON"))
        var item2 = UIBarButtonItem(title: "load XML", style: UIBarButtonItemStyle.Done, target: self, action: Selector("loadXML"))
        var item3 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        toolBar.items = [item3,item1,item3,item2,item3]
        self.view.addSubview(toolBar)
    }
    
    func loadJSON() {
        var urlStr = "http://localhost:7777/swift/test.json"
        // 从web服务器直接加载数据
        // 提示：NSData本身具有同步方法，但是在实际开发中，不要使用此方法。在使用NSData的同步方法时，无法指定超时时间，如果服务器连接不正常，会影响用户体验
        // var data = NSData(contentsOfURL: NSURL(string: urlStr)!)
        // var result = NSString(data: data!, encoding: NSUTF8StringEncoding)
        // println(result)
        
        // 1.建立NSURL
        var url = NSURL(string: urlStr)
        // 2.建立NSURLRequest
        var request = NSURLRequest(URL: url!)
        // 3.利用NSURLConnection的同步方法加载数据
        var error : NSError?
        var response : NSURLResponse?
        var data = NSURLConnection.sendSynchronousRequest(request,returningResponse: &response,error: &error)
        if data != nil {
            handlerJsonData(data!)
        } else if error == nil {
            println("空数据")
        } else {
            println("错误\(error!.localizedDescription)")
        }
        
    }
    
    func handlerJsonData(data:NSData) {
        // 在处理网络数据时，不需要将NSData转换成NSString。仅用于跟踪处理
        var result = NSString(data: data, encoding: NSUTF8StringEncoding)
        // println(result!)
        
        var error:NSError?
        var array = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &error) as NSArray
        
        // 如果开发网络应用，可以将反序列化出来的对象保存到沙箱，以便后续开发使用
        var docs = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = (docs[0] as NSString).stringByAppendingPathComponent("json.plist")
        array.writeToFile(path, atomically: true)
        println(path)
    }
    
    func loadXML() {
//        testExtension()
        
        var urlStr = "http://localhost:7777/swift/test.xml"
        // 1.建立NSURL
        var url = NSURL(string: urlStr)
        // 2.建立NSURLRequest
        var request = NSURLRequest(URL: url!)
        // 3.利用NSURLConnection的同步方法加载数据
        var error : NSError?
        var response : NSURLResponse?
        var data = NSURLConnection.sendSynchronousRequest(request,returningResponse: &response,error: &error)
        if data != nil {
            handlerXmlDataXmlParser(data!)
        } else if error == nil {
            println("空数据")
        } else {
            println("错误\(error!.localizedDescription)")
        }
    }
    
    func handlerXmlDataXmlParser(data:NSData) {
        // var result = NSString(data: data, encoding: NSUTF8StringEncoding)
        // println(result!)
        var parser = NSXMLParser(data: data)!
        parser.delegate = self
        parser.parse()
    }
    
    // 在整个解析xml解析完成之前，2、3、4方法会不断被循环调用
    // 1.解析文档
    func parserDidStartDocument(parser: NSXMLParser) {
        println("开始解析文档")
        if self.dataList == nil {
            self.dataList = NSMutableArray()
        } else {
            self.dataList.removeAllObjects()
        }
        
        if elementStr == nil {
            self.elementStr = NSMutableString()
        } else {
            self.elementStr.setString("")
        }
    }
    // 2.开始解析一个元素
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        println("didStartElement \(elementName)  attributeDict\(attributeDict)")
        if (elementName as NSString).isEqualToString("video") {
            currentVideo = Model()
            var videoId = attributeDict["videoId"] as NSString
            currentVideo.videoId = videoId.integerValue
        }
    }
    
    // 3.接收元素的数据（因为元素的内容过大，此方法可能会被重复调用，需要拼接数据）
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        println("found \(string)")
        elementStr.setString(string)
    }
    // 4.结束解析一个元素
    // namespaceURI: String?, qualifiedName qName: String? 这两处需要自己手动加上？
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        println("didEndElement \(elementName)")
        var eName = elementName as NSString
        if eName.isEqualToString("video") {
            self.dataList.addObject(currentVideo)
        } else if eName.isEqualToString("name")  {
            currentVideo.name = NSString(string: elementStr)
        } else if eName.isEqualToString("length") {
            currentVideo.length = elementStr.integerValue
        }
    }
    
    // 5.解析完档元素
    func parserDidEndDocument(parser: NSXMLParser) {
        println("解析文档结束")

        for model in dataList {
           println("\((model as Model).name)")
        }
    }
    // 6.解析出错
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        println("解析出错 \(parseError.localizedDescription)")
        self.dataList.removeAllObjects()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(CELL_ID) as VideoCell!
        if cell == nil {
            cell = VideoCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: CELL_ID)
        }
        cell.textLabel?.text = "title"
        cell.detailTextLabel?.text = "detail"
        cell.label3.text = "11:11"
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        // 加载图片
        // var imagePath = "http://localhost:7777/swift/hehe.jpg"
        // var imageUrl = NSURL(string: imagePath)!
        // loadImageSync(imageUrl, imageView: cell.imageView!)
        // 异步加载时使用默认图片占位置，既能保证有图像，又能保证有地方
        // cell.imageView?.image = UIImage(named: "default.jpg")
        // loadImageAsync(imageUrl, imageView: cell.imageView!)
        // 正式开发时从数据集中获取获取model
        var model = self.model
        if model.cacheImage == nil {
            // 异步加载时使用默认图片占位置，既能保证有图像，又能保证有地方
            cell.imageView?.image = UIImage(named: "default.jpg")
            loadImageAsyncOther(indexPath)
        } else {
            cell.imageView?.image = model.cacheImage
        }
        // println("加载数据")
        return cell
    }
    
    func loadImageAsyncOther(indexPath:NSIndexPath) {
        // 正式开发时从数据集中获取mode，再获取url
        var model = self.model
        var imagePath = "http://localhost:7777/swift/hehe.jpg"
        var imageUrl = NSURL(string: imagePath)!
        var request = NSURLRequest(URL: imageUrl)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response:NSURLResponse!, data:NSData!, error:NSError!) -> Void in
            model.cacheImage = UIImage(data: data)
            self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Right)
        }
    }
    
    // 由于UITableViewCell是可重用的，为了避免用户频繁快速刷新表格，造成数据冲突，不能直接将UIImageView传入异步方法
    // 正确地解决方法是：将表格行的indexPath传入异步方法，加载完成图像后，直接刷新指定行
    func loadImageAsync(url:NSURL,imageView:UIImageView) {
        var request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response:NSURLResponse!, data:NSData!, error:NSError!) -> Void in
            imageView.image = UIImage(data: data)
        }
    }
    
    func loadImageSync(url:NSURL,imageView:UIImageView) {
        // 1)同步加载图片
        // 注意：在开发网络应用时，不要使用同步方法加载图片，否则会严重影响用户体验
        // 同步方法，意味着，这一指定执行完成之前，后续的指令都无法执行
        var imageData = NSData(contentsOfURL: url)
        imageView.image = UIImage(data: imageData!)
    }

}

extension ViewController {
    func testExtension() {
        println("testExtension")
    }

}