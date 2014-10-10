//
//  ViewController.swift
//  图像水印
//
//  Created by bingoogol on 14/10/10.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var imageView = UIImageView(image: self.waterMaskImage())
        self.view.addSubview(imageView)
    }
    
    // 生成一张新的图片 => 原始图片 + 水印文字
    func waterMaskImage() -> UIImage {
        var imageSize = CGSizeMake(320, 200)
        // 1.建立图像的上下文，需要指定新生成的图像大小
        UIGraphicsBeginImageContext(imageSize)
        
        // 2.绘制内容
        var image = UIImage(named: "NatGeo01.png")
        image?.drawInRect(CGRectMake(0, 0, imageSize.width, imageSize.height))
        // 在整个绘图方法里面实际上是对设备无关的，只要上下文变了，画出来的地方不一样
        // 此时的上下文是图像的上下文
        var context = UIGraphicsGetCurrentContext()
        UIColor.yellowColor().set()
        CGContextAddRect(context, CGRectMake(50, 50, 100, 100))
        CGContextDrawPath(context, kCGPathFill)
        
        // 3.添加水印文字
        var str:NSString = "我的水印"
        
        var paragraphStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as NSMutableParagraphStyle
        paragraphStyle.alignment = NSTextAlignment.Right
        paragraphStyle.lineBreakMode = NSLineBreakMode.ByTruncatingTail
    
        let attributes = [
            NSFontAttributeName: UIFont.systemFontOfSize(16),
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSParagraphStyleAttributeName:paragraphStyle
        ]
        str.drawInRect(CGRectMake(0, imageSize.height - 30, imageSize.width - 10, imageSize.height), withAttributes:attributes)
        // 4.获取到新生成的图像，从当前上下文获取到新绘制的图像
        var newImage = UIGraphicsGetImageFromCurrentImageContext()
        // 5.关闭图像上下文
        UIGraphicsEndImageContext()
        return newImage
    }

}