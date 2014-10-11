//
//  ViewController.swift
//  PDF文件
//
//  Created by bingoogol on 14/10/11.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createPDFFile()
    }
    
    func createPDFFile() {
        //1.创建PDF上下文
        /*
        path 保存pdf文件的路径
        bounds 大小，如果制定CGRectZero，则建立612*792大小的页面
        documentInfo 文档信息
        */
        var array = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = (array[0] as NSString).stringByAppendingPathComponent("123.pdf")
        println(path)
        UIGraphicsBeginPDFContextToFile(path, CGRectZero, nil)
        //2.创建PDF内容
        /*
        pdf中是分页的，要一个页面一个页面的创建
        使用UIGraphicsBeginPDFPage方法可以创建一个pdf的页面
        */
        for i in 0 ... 5 {
            // 1)创建PDF页面，每个页面的装载量是有限的
            // 在默认的页面大小里面，可以装3张图片
            // 每添加了两张图片之后，需要新建一个页面
            if i % 2 == 0 {
                UIGraphicsBeginPDFPage()
            }
            // 2)将image添加到PDF文件
            var image = UIImage(named: "NatGeo0\(i + 1).png")
            image?.drawInRect(CGRectMake(0, CGFloat(i % 2) * 396, 612, 396))
        }
        //3.关闭PDF上下文
        UIGraphicsEndPDFContext()
    }

}