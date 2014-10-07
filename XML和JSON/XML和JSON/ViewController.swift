//
//  ViewController.swift
//  XML和JSON
//
//  Created by bingoogol on 14/10/7.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let CELL_ID = "MyCell"
    var tableView:UITableView!
    var model:Model = Model()
    
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
        println("loadJSON")
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
        println("loadXML")
        testExtension()
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
        println("加载数据")
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